`nix run . ./example/default.nix`

renders

```
{
  "/nix/store/89gq36x34bzs0cgc30xj8phwvd4bsaz6-c.drv" = [
    "/nix/store/k7f6m8bxywkbvjq389yb7i1nqddrsvl6-b.drv"
    "/nix/store/r6shsdbqr2xy5hkkbrds0lihj0r7qb26-a.drv"
  ];
  "/nix/store/yvh4hr1aaxb15iacx1b4h4xc2fl5hw1s-d.drv" = [
  ];
  "/nix/store/agnyb4gd5kpx8dfgnzvn4vl78kngv6q9-e.drv" = [
    "/nix/store/89gq36x34bzs0cgc30xj8phwvd4bsaz6-c.drv"
    "/nix/store/k7f6m8bxywkbvjq389yb7i1nqddrsvl6-b.drv"
    "/nix/store/r6shsdbqr2xy5hkkbrds0lihj0r7qb26-a.drv"
    "/nix/store/yvh4hr1aaxb15iacx1b4h4xc2fl5hw1s-d.drv"
  ];
  "/nix/store/33n34b33zilk3wir9f9gqp684j772krx-f.drv" = [
    "/nix/store/k7f6m8bxywkbvjq389yb7i1nqddrsvl6-b.drv"
    "/nix/store/r6shsdbqr2xy5hkkbrds0lihj0r7qb26-a.drv"
  ];
  "/nix/store/84mbjlxw1dp1pr2jnx25bk99yalwxw1a-g.drv" = [
    "/nix/store/r6shsdbqr2xy5hkkbrds0lihj0r7qb26-a.drv"
  ];
  "/nix/store/jr2mbmldh51wx7xpnxay8pw389ajiarv-h.drv" = [
    "/nix/store/89gq36x34bzs0cgc30xj8phwvd4bsaz6-c.drv"
    "/nix/store/agnyb4gd5kpx8dfgnzvn4vl78kngv6q9-e.drv"
    "/nix/store/k7f6m8bxywkbvjq389yb7i1nqddrsvl6-b.drv"
    "/nix/store/r6shsdbqr2xy5hkkbrds0lihj0r7qb26-a.drv"
    "/nix/store/yvh4hr1aaxb15iacx1b4h4xc2fl5hw1s-d.drv"
  ];
  "/nix/store/r6shsdbqr2xy5hkkbrds0lihj0r7qb26-a.drv" = [
  ];
  "/nix/store/dwijiamfl610x1fg1n2ywb4hzfj54flb-z.drv" = [
    "/nix/store/33n34b33zilk3wir9f9gqp684j772krx-f.drv"
    "/nix/store/84mbjlxw1dp1pr2jnx25bk99yalwxw1a-g.drv"
    "/nix/store/89gq36x34bzs0cgc30xj8phwvd4bsaz6-c.drv"
    "/nix/store/agnyb4gd5kpx8dfgnzvn4vl78kngv6q9-e.drv"
    "/nix/store/jr2mbmldh51wx7xpnxay8pw389ajiarv-h.drv"
    "/nix/store/k7f6m8bxywkbvjq389yb7i1nqddrsvl6-b.drv"
    "/nix/store/r6shsdbqr2xy5hkkbrds0lihj0r7qb26-a.drv"
    "/nix/store/yvh4hr1aaxb15iacx1b4h4xc2fl5hw1s-d.drv"
  ];
  "/nix/store/k7f6m8bxywkbvjq389yb7i1nqddrsvl6-b.drv" = [
    "/nix/store/r6shsdbqr2xy5hkkbrds0lihj0r7qb26-a.drv"
  ];
}
```
