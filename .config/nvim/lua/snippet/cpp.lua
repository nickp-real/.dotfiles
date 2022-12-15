local ls = require("luasnip")

local s, i, t = ls.s, ls.insert_node, ls.text_node

return {
  s({ trig = "comp", name = "Competitive template", dscr = "Competitive programming starting template" }, {
    t({
      "#include <bits/stdc++.h>",
      "using namespace std;",
      "",
      "int main (int argc, char *argv[])",
      "{",
      "\tios::sync_with_stdio(false);",
      "\tcin.tie(nullptr);",
      "\tcout.tie(nullptr);",
      "",
      "\t",
    }),
    i(0),
    t({ "", "\treturn 0;", "}" }),
  }),
}
