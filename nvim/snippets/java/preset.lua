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
local paus = ls.extend_decorator.apply(ls.snippet, { condition = islineone, hidden = true, wordTrig = false, snippetType = 'autosnippet', trigEngine = 'plain' }) -- plain autosnippet line 1

local s =  ls.extend_decorator.apply(ls.snippet, { wordTrig = false, trigEngine = 'plain' }) -- plain snippet
local aus = ls.extend_decorator.apply(ls.snippet, { wordTrig = false, hidden = true, snippetType = 'autosnippet', trigEngine = 'plain' }) -- plain autosnippet
local raus = ls.extend_decorator.apply(ls.snippet, { wordTrig = false, hidden = true, snippetType = 'autosnippet', trigEngine = 'pattern' }) -- regex autosnippet

M = {
  paus(
    'basicfile',
    fmt([=[
    import java.util.*;
    import java.io.*;
    import java.lang.Math;

    // Faster Positives Modulo
    public int fm(int __fmi, int __fmc) { return __fmi < __fmc ? __fmi : __fmi % __fmc; }

    public static void main(String[[]] args) { 
      []
    }]=], {i(0)},{delimiters='[]'})
  ), 

  aus(
    'inputT', fmt([=[
    short __T;
    cin >> __T;
    for (short __t = 1; __t <= __T; __t++) {
      // System.out.println("case" + __t);
      []
    }
    ]=],{i(0)},{delimiters='[]'})
  ),

  aus(
    ';fo', fmt([=[
    for (int [] = 0; [] < []; []++) {
      []
    }
    ]=], {i(1, 'i'), rep(1), i(2,'n'), rep(1), i(3)}, {delimiters='[]'})
  ),

  aus(
    ';if',
    fmt([=[
     if ([]) {
      []
    }
    ]=], {i(1, 'true'), i(2)}, {delimiters='[]'})
  ),

  aus(
    ';ie',
    fmt([=[
     if ([]) {
      []
    } else {
      []
    }
    ]=], {i(1, 'true'), i(2), i(3)}, {delimiters='[]'})
  ),

  aus(
    ';i1',
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
    ';sw',
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
