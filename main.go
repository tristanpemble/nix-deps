package main

import (
	"bytes"
	"flag"
	"fmt"
	"github.com/goccy/go-graphviz"
	"github.com/goccy/go-graphviz/cgraph"
	"log"
	"os/exec"
	"path"
	"sort"
	"strings"
)

func main() {
	flag.Parse()

	file := flag.Arg(0)
	cmd := exec.Command("nix-instantiate", file)

	var stdout bytes.Buffer
	var stderr bytes.Buffer

	cmd.Stdout = &stdout
	cmd.Stderr = &stderr

	err := cmd.Run()
	if err != nil {
		log.Println(err.Error())
		log.Printf("%s", stderr.String())
		return
	}

	drvs := strings.Split(strings.TrimSuffix(stdout.String(), "\n"), "\n")
	nargs := []string{"--query", "--graph"}

	cmd2 := exec.Command("nix-store", append(nargs, drvs...)...)

	var stdout2 bytes.Buffer
	var stderr2 bytes.Buffer

	cmd2.Stdout = &stdout2
	cmd2.Stderr = &stderr2

	err = cmd2.Run()
	if err != nil {
		log.Println(err.Error())
		log.Printf("%s", stderr2.String())
		return
	}

	graph, err := graphviz.ParseBytes(stdout2.Bytes())
	if err != nil {
		log.Println(err.Error())
		return
	}

	m, err := deps(graph, drvs)
	if err != nil {
		log.Println(err.Error())
		return
	}

	fmt.Println("{")
	for drv, deps := range m {
		fmt.Printf("  \"%s\" = [\n", drv)
		for _, drv := range deps {
			fmt.Printf("    \"%s\"\n", drv)
		}
		fmt.Println("  ];")
	}
	fmt.Println("}")
}

func deps(graph *cgraph.Graph, allowed []string) (map[string][]string, error) {
	m := make(map[string][]string)
	for _, drv := range allowed {
		node, err := graph.Node(path.Base(drv))
		if err != nil {
			return nil, err
		}
		m[drv] = []string{}
		for k, v := range depsOf(graph, node, allowed, path.Dir(drv), map[string]bool{}) {
			if v {
				m[drv] = append(m[drv], k)
			}
		}
		sort.Strings(m[drv])
	}
	return m, nil
}

func depsOf(graph *cgraph.Graph, node *cgraph.Node, allowed []string, store string, deps map[string]bool) map[string]bool {
	for e := graph.FirstIn(node); e != nil; e = graph.NextIn(e) {
		drv := path.Join(store, e.Node().Name())

		if _, ok := deps[drv]; ok {
			continue
		}

		deps[drv] = contains(drv, allowed)

		for drv, v := range depsOf(graph, e.Node(), allowed, store, deps) {
			deps[drv] = v
		}
	}

	return deps
}

func contains(val string, list []string) bool {
	for _, v := range list {
		if v == val {
			return true
		}
	}
	return false
}
