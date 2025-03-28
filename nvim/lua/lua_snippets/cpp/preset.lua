local ls = require("luasnip")
-- local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

function islineone() return vim.fn.getpos(".")[2] == 1 end

local ps =  ls.extend_decorator.apply(ls.snippet, { condition = islineone, show_condition = islineone, wordTrig = false, trigEngine = 'plain' }) -- plain snippet line 1
local paus = ls.extend_decorator.apply(ls.snippet, { condition = islineone, show_condition = islineone, wordTrig = false, snippetType = 'autosnippet', trigEngine = 'plain' }) -- plain autosnippet line 1

local s =  ls.extend_decorator.apply(ls.snippet, { wordTrig = false, trigEngine = 'plain' }) -- plain snippet
local aus = ls.extend_decorator.apply(ls.snippet, { wordTrig = false, snippetType = 'autosnippet', trigEngine = 'plain' }) -- plain autosnippet
local raus = ls.extend_decorator.apply(ls.snippet, { wordTrig = false, snippetType = 'autosnippet', trigEngine = 'pattern' }) -- regex autosnippet

M = {
  paus(
    'compfull',
    fmt([=[
    #include <algorithm>
    #include <cmath>
    #include <climits>
    #include <deque>
    #include <iostream>
    #include <iterator>
    #include <map>
    #include <numeric>
    #include <queue>
    #include <set>
    #include <stack>
    #include <unordered_map>
    #include <unordered_set>
    #include <utility>
    #include <vector>

    using namespace std;
    typedef long double ld;
    typedef long long ll;
    typedef int ii;
    typedef short ss;
    typedef unsigned long long ull;
    typedef unsigned int uii;
    typedef unsigned short uss;
    #define pr pair
    template <class T> using V = vector<T>;

    #define endl '\n'

    #define MOD 1000000007;
    #define PI 3.1415926535897932384626433832795;
    #define EPS = 1e-9;
    #define INF = 1e9;

    // Faster Positives Modulo
    uss fm(const uss __fmi, const uss __fmc) { return __fmi < __fmc ? __fmi : __fmi % __fmc; }
    uii fm(const uii __fmi, const uii __fmc) { return __fmi < __fmc ? __fmi : __fmi % __fmc; }
    ull fm(const ull __fmi, const ull __fmc) { return __fmi < __fmc ? __fmi : __fmi % __fmc; }

    int main() {
      ios_base::sync_with_stdio(false);
      cin.tie(NULL);
      cout.tie(NULL);
      []
      return 0;
    }]=], {i(0)}, {delimiters='[]'})
  ), 

  paus(
    'compmin',
    fmt([=[
    #include <algorithm>
    #include <cmath>
    #include <climits>
    #include <iostream>
    #include <numeric>
    #include <vector>

    using namespace std;
    typedef long long ll;
    typedef int ii;
    typedef short ss;
    typedef unsigned long long ull;
    typedef unsigned int uii;
    typedef unsigned short uss;
    template <class T> using V = vector<T>;

    #define endl '\n'

    #define MOD 1000000007;

    int main() {
      ios_base::sync_with_stdio(false);
      cin.tie(NULL);
      cout.tie(NULL);
      []
      return 0;
    }]=], {i(0)}, {delimiters='[]'})
  ), 

  aus(
    'inputT', fmt([=[
    uss __T;
    cin >> __T;
    for (uss __t = 1; __t <= __T; __t++) {
      // cout << "case" << __t << endl;
      []
    }
    ]=],{i(0)},{delimiters='[]'})
  ),

  aus(
    'forl', fmt([=[
    for (int [] = 0; [] < []; []++) {
      []
    }
    ]=], {i(1, 'i'), rep(1), i(2,'n'), rep(1), i(3)}, {delimiters='[]'})
  ),

  aus(
    ' iff',
    fmt([=[
     if ([]) {
      []
    }
    ]=], {i(1, 'true'), i(2)}, {delimiters='[]'})
  ),

  aus(
    ' ife',
    fmt([=[
     if ([]) {
      []
    } else {
      []
    }
    ]=], {i(1, 'true'), i(2), i(3)}, {delimiters='[]'})
  ),

  aus(
    'if1',
    fmt([=[
    if ([]) {
      []
    } elif ([]) {
      []
    } else {
      []
    }
    ]=], {i(1, 'true'), i(2), i(3,'true'), i(4), i(5)}, {delimiters='[]'})
  ),

  aus(
    'swc',
    fmt([=[
    switch([]) {
      case []: {
        []
        break;
      }
      case []: {
        []
        break;
      }
    }
    ]=], {i(1, 'x'), i(2,'1'), i(3), i(4,'2'), i(5)}, {delimiters='[]'})
  ),
}
return M
