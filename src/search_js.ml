(*
 * This file is part of Argot.
 * Copyright (C) 2010-2011 Xavier Clerc.
 *
 * Argot is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 *
 * Argot is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *)

let parser = [
  "/* Jison generated parser */";
  "var argot_parser = (function(){";
  "";
  "var parser = {trace: function trace() { },";
  "yy: {},";
  "symbols_: {\"error\":2,\"signature\":3,\"type\":4,\"EOF\":5,\"IDENT\":6,\"VAR\":7,\"*\":8,\"->\":9,\"(\":10,\"type_list\":11,\")\":12,\"ident_list\":13,\",\":14,\"$accept\":0,\"$end\":1},";
  "terminals_: {2:\"error\",5:\"EOF\",6:\"IDENT\",7:\"VAR\",8:\"*\",9:\"->\",10:\"(\",12:\")\",14:\",\"},";
  "productions_: [0,[3,2],[4,1],[4,1],[4,3],[4,3],[4,3],[4,4],[4,2],[4,2],[13,2],[13,1],[11,3],[11,1]],";
  "performAction: function anonymous(yytext,yyleng,yylineno,yy,yystate,$$,_$) {";
  "";
  "var $0 = $$.length - 1;";
  "switch (yystate) {";
  "case 1: return $$[$0-1]; ";
  "break;";
  "case 2: this.$ = $$[$0]; ";
  "break;";
  "case 3: this.$ = $$[$0]; ";
  "break;";
  "case 4: this.$ = product($$[$0-2], $$[$0]); ";
  "break;";
  "case 5: this.$ = arrow($$[$0-2], $$[$0]); ";
  "break;";
  "case 6: if ($$[$0-1].length == 1) { this.$ = $$[$0-1][0]; }";
  "                                     else { throw \"invalid input\"; }  ";
  "break;";
  "case 7: $$[$0-2].kind = KIND_TYPE_LIST;";
  "                                     $$[$0].unshift($$[$0-2]); $$[$0].kind = KIND_TYPE_APP; this.$ = $$[$0];  ";
  "break;";
  "case 8: $$[$0].unshift($$[$0-1]); $$[$0].kind = KIND_TYPE_APP; this.$ = $$[$0]; ";
  "break;";
  "case 9: $$[$0].unshift($$[$0-1]); $$[$0].kind = KIND_TYPE_APP; this.$ = $$[$0]; ";
  "break;";
  "case 10: this.$ = $$[$0-1].concat($$[$0]); ";
  "break;";
  "case 11: this.$ = [$$[$0]]; ";
  "break;";
  "case 12: this.$ = $$[$0-2].concat($$[$0]); ";
  "break;";
  "case 13: this.$ = [$$[$0]]; ";
  "break;";
  "}";
  "},";
  "table: [{3:1,4:2,6:[1,3],7:[1,4],10:[1,5]},{1:[3]},{5:[1,6],8:[1,7],9:[1,8]},{5:[2,2],6:[1,10],8:[2,2],9:[2,2],12:[2,2],13:9,14:[2,2]},{5:[2,3],6:[1,10],8:[2,3],9:[2,3],12:[2,3],13:11,14:[2,3]},{4:13,6:[1,3],7:[1,4],10:[1,5],11:12},{1:[2,1]},{4:14,6:[1,3],7:[1,4],10:[1,5]},{4:15,6:[1,3],7:[1,4],10:[1,5]},{5:[2,8],6:[1,16],8:[2,8],9:[2,8],12:[2,8],14:[2,8]},{5:[2,11],6:[2,11],8:[2,11],9:[2,11],12:[2,11],14:[2,11]},{5:[2,9],6:[1,16],8:[2,9],9:[2,9],12:[2,9],14:[2,9]},{12:[1,17],14:[1,18]},{8:[1,7],9:[1,8],12:[2,13],14:[2,13]},{5:[2,4],8:[2,4],9:[2,4],12:[2,4],14:[2,4]},{5:[2,5],8:[1,7],9:[1,8],12:[2,5],14:[2,5]},{5:[2,10],6:[2,10],8:[2,10],9:[2,10],12:[2,10],14:[2,10]},{5:[2,6],6:[1,10],8:[2,6],9:[2,6],12:[2,6],13:19,14:[2,6]},{4:20,6:[1,3],7:[1,4],10:[1,5]},{5:[2,7],6:[1,16],8:[2,7],9:[2,7],12:[2,7],14:[2,7]},{8:[1,7],9:[1,8],12:[2,12],14:[2,12]}],";
  "defaultActions: {6:[2,1]},";
  "parseError: function parseError(str, hash) {";
  "    throw new Error(str);";
  "},";
  "parse: function parse(input) {";
  "    var self = this,";
  "        stack = [0],";
  "        vstack = [null], // semantic value stack";
  "        lstack = [], // location stack";
  "        table = this.table,";
  "        yytext = '',";
  "        yylineno = 0,";
  "        yyleng = 0,";
  "        recovering = 0,";
  "        TERROR = 2,";
  "        EOF = 1;";
  "";
  "    //this.reductionCount = this.shiftCount = 0;";
  "";
  "    this.lexer.setInput(input);";
  "    this.lexer.yy = this.yy;";
  "    this.yy.lexer = this.lexer;";
  "    if (typeof this.lexer.yylloc == 'undefined')";
  "        this.lexer.yylloc = {};";
  "    var yyloc = this.lexer.yylloc;";
  "    lstack.push(yyloc);";
  "";
  "    if (typeof this.yy.parseError === 'function')";
  "        this.parseError = this.yy.parseError;";
  "";
  "    function popStack (n) {";
  "        stack.length = stack.length - 2*n;";
  "        vstack.length = vstack.length - n;";
  "        lstack.length = lstack.length - n;";
  "    }";
  "";
  "    function lex() {";
  "        var token;";
  "        token = self.lexer.lex() || 1; // $end = 1";
  "        // if token isn't its numeric value, convert";
  "        if (typeof token !== 'number') {";
  "            token = self.symbols_[token] || token;";
  "        }";
  "        return token;";
  "    };";
  "";
  "    var symbol, preErrorSymbol, state, action, a, r, yyval={},p,len,newState, expected;";
  "    while (true) {";
  "        // retreive state number from top of stack";
  "        state = stack[stack.length-1];";
  "";
  "        // use default actions if available";
  "        if (this.defaultActions[state]) {";
  "            action = this.defaultActions[state];";
  "        } else {";
  "            if (symbol == null)";
  "                symbol = lex();";
  "            // read action for current state and first input";
  "            action = table[state] && table[state][symbol];";
  "        }";
  "";
  "        // handle parse error";
  "        if (typeof action === 'undefined' || !action.length || !action[0]) {";
  "";
  "            if (!recovering) {";
  "                // Report error";
  "                expected = [];";
  "                for (p in table[state]) if (this.terminals_[p] && p > 2) {";
  "                    expected.push(\"'\"+this.terminals_[p]+\"'\");";
  "                }";
  "                var errStr = '';";
  "                if (this.lexer.showPosition) {";
  "                    errStr = 'Parse error on line '+(yylineno+1)+\":\\n\"+this.lexer.showPosition()+'\\nExpecting '+expected.join(', ');";
  "                } else {";
  "                    errStr = 'Parse error on line '+(yylineno+1)+\": Unexpected \" +";
  "                                  (symbol == 1 /*EOF*/ ? \"end of input\" :";
  "                                              (\"'\"+(this.terminals_[symbol] || symbol)+\"'\"));";
  "                }";
  "                this.parseError(errStr,";
  "                    {text: this.lexer.match, token: this.terminals_[symbol] || symbol, line: this.lexer.yylineno, loc: yyloc, expected: expected});";
  "            }";
  "";
  "            // just recovered from another error";
  "            if (recovering == 3) {";
  "                if (symbol == EOF) {";
  "                    throw new Error(errStr || 'Parsing halted.');";
  "                }";
  "";
  "                // discard current lookahead and grab another";
  "                yyleng = this.lexer.yyleng;";
  "                yytext = this.lexer.yytext;";
  "                yylineno = this.lexer.yylineno;";
  "                yyloc = this.lexer.yylloc;";
  "                symbol = lex();";
  "            }";
  "";
  "            // try to recover from error";
  "            while (1) {";
  "                // check for error recovery rule in this state";
  "                if ((TERROR.toString()) in table[state]) {";
  "                    break;";
  "                }";
  "                if (state == 0) {";
  "                    throw new Error(errStr || 'Parsing halted.');";
  "                }";
  "                popStack(1);";
  "                state = stack[stack.length-1];";
  "            }";
  "";
  "            preErrorSymbol = symbol; // save the lookahead token";
  "            symbol = TERROR;         // insert generic error symbol as new lookahead";
  "            state = stack[stack.length-1];";
  "            action = table[state] && table[state][TERROR];";
  "            recovering = 3; // allow 3 real symbols to be shifted before reporting a new error";
  "        }";
  "";
  "        // this shouldn't happen, unless resolve defaults are off";
  "        if (action[0] instanceof Array && action.length > 1) {";
  "            throw new Error('Parse Error: multiple actions possible at state: '+state+', token: '+symbol);";
  "        }";
  "";
  "        switch (action[0]) {";
  "";
  "            case 1: // shift";
  "                //this.shiftCount++;";
  "";
  "                stack.push(symbol);";
  "                vstack.push(this.lexer.yytext);";
  "                lstack.push(this.lexer.yylloc);";
  "                stack.push(action[1]); // push state";
  "                symbol = null;";
  "                if (!preErrorSymbol) { // normal execution/no error";
  "                    yyleng = this.lexer.yyleng;";
  "                    yytext = this.lexer.yytext;";
  "                    yylineno = this.lexer.yylineno;";
  "                    yyloc = this.lexer.yylloc;";
  "                    if (recovering > 0)";
  "                        recovering--;";
  "                } else { // error just occurred, resume old lookahead f/ before error";
  "                    symbol = preErrorSymbol;";
  "                    preErrorSymbol = null;";
  "                }";
  "                break;";
  "";
  "            case 2: // reduce";
  "                //this.reductionCount++;";
  "";
  "                len = this.productions_[action[1]][1];";
  "";
  "                // perform semantic action";
  "                yyval.$ = vstack[vstack.length-len]; // default to $$ = $1";
  "                // default location, uses first token for firsts, last for lasts";
  "                yyval._$ = {";
  "                    first_line: lstack[lstack.length-(len||1)].first_line,";
  "                    last_line: lstack[lstack.length-1].last_line,";
  "                    first_column: lstack[lstack.length-(len||1)].first_column,";
  "                    last_column: lstack[lstack.length-1].last_column";
  "                };";
  "                r = this.performAction.call(yyval, yytext, yyleng, yylineno, this.yy, action[1], vstack, lstack);";
  "";
  "                if (typeof r !== 'undefined') {";
  "                    return r;";
  "                }";
  "";
  "                // pop off stack";
  "                if (len) {";
  "                    stack = stack.slice(0,-1*len*2);";
  "                    vstack = vstack.slice(0, -1*len);";
  "                    lstack = lstack.slice(0, -1*len);";
  "                }";
  "";
  "                stack.push(this.productions_[action[1]][0]);    // push nonterminal (reduce)";
  "                vstack.push(yyval.$);";
  "                lstack.push(yyval._$);";
  "                // goto new state = table[STATE][NONTERMINAL]";
  "                newState = table[stack[stack.length-2]][stack[stack.length-1]];";
  "                stack.push(newState);";
  "                break;";
  "";
  "            case 3: // accept";
  "                return true;";
  "        }";
  "";
  "    }";
  "";
  "    return true;";
  "}};/* Jison generated lexer */";
  "var lexer = (function(){";
  "";
  "var lexer = ({EOF:1,";
  "parseError:function parseError(str, hash) {";
  "        if (this.yy.parseError) {";
  "            this.yy.parseError(str, hash);";
  "        } else {";
  "            throw new Error(str);";
  "        }";
  "    },";
  "setInput:function (input) {";
  "        this._input = input;";
  "        this._more = this._less = this.done = false;";
  "        this.yylineno = this.yyleng = 0;";
  "        this.yytext = this.matched = this.match = '';";
  "        this.conditionStack = ['INITIAL'];";
  "        this.yylloc = {first_line:1,first_column:0,last_line:1,last_column:0};";
  "        return this;";
  "    },";
  "input:function () {";
  "        var ch = this._input[0];";
  "        this.yytext+=ch;";
  "        this.yyleng++;";
  "        this.match+=ch;";
  "        this.matched+=ch;";
  "        var lines = ch.match(/\\n/);";
  "        if (lines) this.yylineno++;";
  "        this._input = this._input.slice(1);";
  "        return ch;";
  "    },";
  "unput:function (ch) {";
  "        this._input = ch + this._input;";
  "        return this;";
  "    },";
  "more:function () {";
  "        this._more = true;";
  "        return this;";
  "    },";
  "pastInput:function () {";
  "        var past = this.matched.substr(0, this.matched.length - this.match.length);";
  "        return (past.length > 20 ? '...':'') + past.substr(-20).replace(/\\n/g, \"\");";
  "    },";
  "upcomingInput:function () {";
  "        var next = this.match;";
  "        if (next.length < 20) {";
  "            next += this._input.substr(0, 20-next.length);";
  "        }";
  "        return (next.substr(0,20)+(next.length > 20 ? '...':'')).replace(/\\n/g, \"\");";
  "    },";
  "showPosition:function () {";
  "        var pre = this.pastInput();";
  "        var c = new Array(pre.length + 1).join(\"-\");";
  "        return pre + this.upcomingInput() + \"\\n\" + c+\"^\";";
  "    },";
  "next:function () {";
  "        if (this.done) {";
  "            return this.EOF;";
  "        }";
  "        if (!this._input) this.done = true;";
  "";
  "        var token,";
  "            match,";
  "            col,";
  "            lines;";
  "        if (!this._more) {";
  "            this.yytext = '';";
  "            this.match = '';";
  "        }";
  "        var rules = this._currentRules();";
  "        for (var i=0;i < rules.length; i++) {";
  "            match = this._input.match(this.rules[rules[i]]);";
  "            if (match) {";
  "                lines = match[0].match(/\\n.*/g);";
  "                if (lines) this.yylineno += lines.length;";
  "                this.yylloc = {first_line: this.yylloc.last_line,";
  "                               last_line: this.yylineno+1,";
  "                               first_column: this.yylloc.last_column,";
  "                               last_column: lines ? lines[lines.length-1].length-1 : this.yylloc.last_column + match[0].length}";
  "                this.yytext += match[0];";
  "                this.match += match[0];";
  "                this.matches = match;";
  "                this.yyleng = this.yytext.length;";
  "                this._more = false;";
  "                this._input = this._input.slice(match[0].length);";
  "                this.matched += match[0];";
  "                token = this.performAction.call(this, this.yy, this, rules[i],this.conditionStack[this.conditionStack.length-1]);";
  "                if (token) return token;";
  "                else return;";
  "            }";
  "        }";
  "        if (this._input === \"\") {";
  "            return this.EOF;";
  "        } else {";
  "            this.parseError('Lexical error on line '+(this.yylineno+1)+'. Unrecognized text.\\n'+this.showPosition(), ";
  "                    {text: \"\", token: null, line: this.yylineno});";
  "        }";
  "    },";
  "lex:function lex() {";
  "        var r = this.next();";
  "        if (typeof r !== 'undefined') {";
  "            return r;";
  "        } else {";
  "            return this.lex();";
  "        }";
  "    },";
  "begin:function begin(condition) {";
  "        this.conditionStack.push(condition);";
  "    },";
  "popState:function popState() {";
  "        return this.conditionStack.pop();";
  "    },";
  "_currentRules:function _currentRules() {";
  "        return this.conditions[this.conditionStack[this.conditionStack.length-1]].rules;";
  "    }});";
  "lexer.performAction = function anonymous(yy,yy_,$avoiding_name_collisions,YY_START) {";
  "";
  "var YYSTATE=YY_START";
  "switch($avoiding_name_collisions) {";
  "case 0: /* ignore whitespace */ ";
  "break;";
  "case 1: return 6; ";
  "break;";
  "case 2: return 7; ";
  "break;";
  "case 3: return 10; ";
  "break;";
  "case 4: return 12; ";
  "break;";
  "case 5: return 8; ";
  "break;";
  "case 6: return 9; ";
  "break;";
  "case 7: return 14; ";
  "break;";
  "case 8: return 5; ";
  "break;";
  "case 9: return 'INVALID'; ";
  "break;";
  "}";
  "};";
  "lexer.rules = [/^\\s+/,/^[a-zA-Z_\\.][a-zA-Z0-9_\\'\\.]*/,/^'[a-zA-Z_\\.][a-zA-Z0-9_\\'\\.]*/,/^\\(/,/^\\)/,/^\\*/,/^->/,/^,/,/^$/,/^./];";
  "lexer.conditions = {\"INITIAL\":{\"rules\":[0,1,2,3,4,5,6,7,8,9],\"inclusive\":true}};return lexer;})()";
  "parser.lexer = lexer;";
  "return parser;";
  "})();";
  "if (typeof require !== 'undefined' && typeof exports !== 'undefined') {";
  "exports.parser = argot_parser;";
  "exports.parse = function () { return argot_parser.parse.apply(argot_parser, arguments); }";
  "exports.main = function commonjsMain(args) {";
  "    if (!args[1])";
  "        throw new Error('Usage: '+args[0]+' FILE');";
  "    if (typeof process !== 'undefined') {";
  "        var source = require('fs').readFileSync(require('path').join(process.cwd(), args[1]), \"utf8\");";
  "    } else {";
  "        var cwd = require(\"file\").path(require(\"file\").cwd());";
  "        var source = cwd.join(args[1]).read({charset: \"utf-8\"});";
  "    }";
  "    return exports.parser.parse(source);";
  "}";
  "if (typeof module !== 'undefined' && require.main === module) {";
  "  exports.main(typeof process !== 'undefined' ? process.argv.slice(1) : require(\"system\").args);";
  "}";
  "}";
]

let search = [
  "//";
  "// This file is part of Argot.";
  "// Copyright (C) 2010-2011 Xavier Clerc.";
  "//";
  "// Argot is free software; you can redistribute it and/or modify";
  "// it under the terms of the GNU General Public License as published by";
  "// the Free Software Foundation; either version 3 of the License, or";
  "// (at your option) any later version.";
  "//";
  "// Argot is distributed in the hope that it will be useful,";
  "// but WITHOUT ANY WARRANTY; without even the implied warranty of";
  "// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the";
  "// GNU General Public License for more details.";
  "//";
  "// You should have received a copy of the GNU General Public License";
  "// along with this program.  If not, see <http://www.gnu.org/licenses/>.";
  "//";
  "";
  "// Global name table: mapping from names to list of OCaml elements";
  "var names = new Object();";
  "";
  "// Global instance table: list of all OCaml elements";
  "var instances = new Array();";
  "";
  "// Adds the element 'e' with name 'n' to the name table";
  "function names_add(n, e) {";
  "    list = names[n];";
  "    if (!list) {";
  "        list = new Array();";
  "        names[n] = list;";
  "    }";
  "    list.push(e);";
  "}";
  "";
  "// Parse the passed string into a type";
  "function parse_type(s) {";
  "    return argot_parser.parse(s);";
  "}";
  "";
  "// Constructs an 'OCaml_type'";
  "function OCaml_type(t) {";
  "    this.type_as_string = t;";
  "    try {";
  "        this.type_as_normal_form = normalize(parse_type(t));";
  "    } catch (e) {";
  "        this.type_as_normal_form = null";
  "    }";
  "}";
  "";
  "// Converts an OCaml type into a string";
  "function string_of_type(t) {";
  "    return t.type_as_string;";
  "}";
  "";
  "// Compares two types";
  "function same_type(x, y) {";
  "    if ((x.type_as_normal_form == null) || (y.type_as_normal_form == null)) {";
  "        return x.type_as_string.replace(/ /g, '') == y.type_as_string.replace(/ /g, '');";
  "    } else {";
  "        return equal_normal_form(x.type_as_normal_form, y.type_as_normal_form);";
  "    }";
  "}";
  "";
  "// Constructs an 'OCaml_element'";
  "function OCaml_element(sn, fn, k, t, r, d) {";
  "    this.short_name = sn;";
  "    this.full_name = fn;";
  "    this.kind = k;";
  "    this.type = new OCaml_type(t);";
  "    this.reference = r;";
  "    this.documentation = d;";
  "}";
  "";
  "// Compares two OCaml elements (using full names)";
  "function compare(x, y) {";
  "    if (x.full_name < y.full_name) {";
  "        return -1;";
  "    } else if (x.full_name > y.full_name) {";
  "        return 1;";
  "    } else {";
  "        return 0;";
  "    }";
  "}";
  "";
  "// Adds an instance to the table";
  "function add_ocaml_element(sn, fn, k, t, r, d) {";
  "    var x = new OCaml_element(sn, fn, k, t, r, d);";
  "    names_add(sn, x);";
  "    if (sn != fn) {";
  "        names_add(fn, x);";
  "    }";
  "    instances.push(x);";
  "}";
  "";
  "// Points the opening window to the passed address";
  "function point_to(addr) {";
  "    if (addr != '') {";
  "        window.opener.location = addr;";
  "        window.opener.focus();";
  "    }";
  "}";
  "";
  "// Formats a result entry";
  "function format(addr, name, alt, type, doc) {";
  "    var action = \"javascript:point_to('\" + addr + \"');\";";
  "    return '<tt><a href=\"#\" onclick=\"' + action + '\" alt=\"' + alt + '\">'";
  "        + name";
  "        + '</a>: ' + type + '</tt><br/>\\n'";
  "        + '<div class=\"argot_result\">' + doc + '</div><br/>\\n';";
  "}";
  "";
  "// Sets the result into the HTML page";
  "function set_result(res) {";
  "    res.sort(compare);";
  "    var text = '';";
  "    var len = res.length;";
  "    for (i = 0; i < len; i++) {";
  "        var elem = res[i];";
  "        text += format(elem.reference,";
  "                       elem.full_name,";
  "                       elem.kind,";
  "                       string_of_type(elem.type),";
  "                       elem.documentation);";
  "    }";
  "    document.getElementById(\"results\").innerHTML = text;";
  "}";
  "";
  "// Performs a search by exact name";
  "function search_by_name(query) {";
  "    var res = new Array();";
  "    var elems = names[query];";
  "    if (elems) {";
  "        var len = elems.length;";
  "        for (i = 0; i < len; i++) {";
  "            res.push(elems[i]);";
  "        }";
  "    }";
  "    set_result(res);";
  "}";
  "";
  "// Performs a search by regular expression match";
  "function search_by_regexp(query) {";
  "    var res = new Array();";
  "    var regexp = new RegExp('^' + query + '$', 'g');";
  "    var len = instances.length;";
  "    for (i = 0; i < len; i++) {";
  "        var inst = instances[i];";
  "        var match = regexp.test(inst.short_name) || regexp.test(inst.full_name);";
  "        if (match) {";
  "            res.push(inst);";
  "        }";
  "    }";
  "    set_result(res);";
  "}";
  "";
  "// Performs a search by type match";
  "function search_by_type(query) {";
  "    var res = new Array();";
  "    var len = instances.length;";
  "    var patt = new OCaml_type(query);";
  "    for (i = 0; i < len; i++) {";
  "        var inst = instances[i];";
  "        if (same_type(inst.type, patt)) {";
  "            res.push(inst);";
  "        }";
  "    }";
  "    set_result(res);";
  "}";
  "";
  "// Actually executes a query";
  "function exec_query() {";
  "    var q = document.form.query.value;";
  "    if (q != '') {";
  "        if (document.form.mode[0].checked) {";
  "            search_by_name(q);";
  "        } else if (document.form.mode[1].checked) {";
  "            search_by_regexp(q);";
  "        } else if (document.form.mode[2].checked) {";
  "            search_by_type(q);";
  "        } else {";
  "            alert('internal error');";
  "        }";
  "    }";
  "}";
]

let types = [
  "//";
  "// This file is part of Argot.";
  "// Copyright (C) 2010-2011 Xavier Clerc.";
  "//";
  "// Argot is free software; you can redistribute it and/or modify";
  "// it under the terms of the GNU General Public License as published by";
  "// the Free Software Foundation; either version 3 of the License, or";
  "// (at your option) any later version.";
  "//";
  "// Argot is distributed in the hope that it will be useful,";
  "// but WITHOUT ANY WARRANTY; without even the implied warranty of";
  "// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the";
  "// GNU General Public License for more details.";
  "//";
  "// You should have received a copy of the GNU General Public License";
  "// along with this program.  If not, see <http://www.gnu.org/licenses/>.";
  "//";
  "";
  "// Tags for elements";
  "var KIND_PRODUCT = 0;";
  "var KIND_ARROW = 1;";
  "var KIND_TYPE_LIST = 2;";
  "var KIND_TYPE_APP = 3;";
  "var KIND_VAR = 4;";
  "var KIND_IDENT = 5;";
  "var KIND_FLATTENED_PRODUCT = 6;";
  "var KIND_FLATTENED_ARROW = 7;";
  "";
  "// Constructs a product from the passed elements";
  "function product(x, y) {";
  "    var res = [x, y];";
  "    res.kind = KIND_PRODUCT;";
  "    return res;";
  "}";
  "";
  "// Constructs an arrow from the passed elements";
  "function arrow(x, y) {";
  "    var res = [x, y];";
  "    res.kind = KIND_ARROW;";
  "    return res;";
  "}";
  "";
  "// Returns the kind of a given value";
  "function kind(x) {";
  "    if (x instanceof Array) {";
  "        return x.kind;";
  "    } else {";
  "        return (x[0] == \"'\") ? KIND_VAR : KIND_IDENT;";
  "    }";
  "}";
  "";
  "// Tests whether the passed type is 'unit'";
  "function is_unit(t) {";
  "    return (kind(t) == KIND_IDENT) && (t == 'unit');";
  "}";
  "";
  "// Tests whether the second element is part of the first one";
  "function mem(arr, x) {";
  "    var len = arr.length;";
  "    var i = 0;";
  "    while ((i < len) && (arr[i] != x)) {";
  "        i++;";
  "    }";
  "    return (i < len);";
  "}";
  "";
  "// Returns the set of variables occurring in the passed type";
  "function get_variables(x) {";
  "    if (x instanceof Array) {";
  "        var res = new Array();";
  "        var len = x.length;";
  "        for (var i = 0; i < len; i++) {";
  "            var elems = get_variables(x[i]);";
  "            var nb = elems.length;";
  "            for (var j = 0; j < nb; j++) {";
  "                if (!mem(res ,elems[j])) {";
  "                    res.push(elems[j]);";
  "                }";
  "            }";
  "        }";
  "        return res;";
  "    } else if (x[0] == \"'\") {";
  "        return [x];";
  "    } else {";
  "        return [];";
  "    }";
  "}";
  "";
  "// Returns the separator corresponding to the passed kind";
  "function separator_of_kind(k) {";
  "    switch (k) {";
  "    case KIND_PRODUCT:";
  "        return ' * ';";
  "    case KIND_ARROW:";
  "        return ' -> ';";
  "    case KIND_TYPE_LIST:";
  "        return ', ';";
  "    case KIND_TYPE_APP:";
  "        return ' ';";
  "    case KIND_FLATTENED_PRODUCT:";
  "        return ' & ';";
  "    case KIND_FLATTENED_ARROW:";
  "        return ' => ';";
  "    default:";
  "        return ' ';";
  "    }";
  "}";
  "";
  "// Converts the passed type into a string";
  "function string_of_type(t) {";
  "    if (t instanceof Array) {";
  "        var sep = separator_of_kind(kind(t));";
  "        var res = \"(\";";
  "        var i = 0;";
  "        for (i = 0; i < t.length; i++) {";
  "            if (i > 0) res += sep;";
  "            res += string_of_type(t[i]);";
  "        }";
  "        return res + \")\";";
  "    } else {";
  "        return t + \"\";";
  "    }";
  "}";
  "";
  "// Rewrites the passed (top) type";
  "function rewrite_type_top(t) {";
  "    switch (t.kind) {";
  "    case KIND_PRODUCT:";
  "    case KIND_ARROW:";
  "        var p = [rewrite_type_top(t[0]), rewrite_type_top(t[1])];";
  "        p.kind = t.kind;";
  "        return rewrite_type_inner(p);";
  "    default:";
  "        return t;";
  "    }";
  "}";
  "";
  "// Rewrites the passed (inner) type";
  "function rewrite_type_inner(t) {";
  "    switch (kind(t)) {";
  "    case KIND_ARROW:";
  "        if (is_unit(t[0])) { // r7";
  "            return t[1];";
  "        } else if (kind(t[0]) == KIND_PRODUCT) { // r2";
  "            var arr = arrow(t[0][1], t[1]);";
  "            var res = arrow(t[0][0], rewrite_type_inner(arr));";
  "            return rewrite_type_inner(res);";
  "        } else if (kind(t[1]) == KIND_PRODUCT) { // r3";
  "            var left = arrow(t[0], t[1][0]);";
  "            var right = arrow(t[0], t[1][1]);";
  "            return product(rewrite_type_inner(left), rewrite_type_inner(right));";
  "        } else {";
  "            return t;";
  "        }";
  "    case KIND_PRODUCT:";
  "        if (is_unit(t[0])) { // r5";
  "            return t[1];";
  "        } else if (is_unit(t[1])) { // r4";
  "            return t[0];";
  "        } else {";
  "            return t;";
  "        }";
  "    default:";
  "        return t;";
  "    }";
  "}";
  "";
  "// Flattens type 't' of a given kind 'k'";
  "function flatten(t, k) {";
  "    if (kind(t) == k) {";
  "        var left = flatten(t[0], k);";
  "        var right = flatten(t[1], k);";
  "        return left.concat(right);";
  "    } else {";
  "        return [t];";
  "    }";
  "}";
  "";
  "// Returns the normal form of the passed type";
  "function normalize(t) {";
  "    var nf = rewrite_type_top(t);";
  "    var res = flatten(nf, KIND_PRODUCT);";
  "    var len = res.length;";
  "    for (var i = 0; i < len; i++) {";
  "        res[i] = flatten(res[i], KIND_ARROW);";
  "        res[i].kind = KIND_FLATTENED_ARROW;";
  "    }";
  "    res.kind = KIND_FLATTENED_PRODUCT;";
  "    return res;";
  "}";
  "";
  "// Returns the list (as an array) from 0 (inclusive) to 'n' (exclusive)";
  "function integers(n) {";
  "    var res = new Array();";
  "    for (var i = 0; i < n; i++) {";
  "        res.push(i);";
  "    }";
  "    return res;";
  "}";
  "";
  "// Helper function for permutations generation";
  "function permuts(tmp, l, res) {";
  "    var len = l.length;";
  "    if (len == 0) {";
  "        res.push(tmp.concat([]));";
  "    }";
  "    for (var i = 0; i < len; i++) {";
  "        var x = l.splice(i, 1);";
  "        tmp.push(x);";
  "        permuts(tmp, l, res);";
  "        tmp.pop();";
  "        l.splice(i, 0, x);";
  "    }";
  "}";
  "";
  "// Returns the permutations from 0 (inclusive) to 'n' (exclusive)";
  "function permutations(n) {";
  "    var res = new Array();";
  "    permuts([], integers(n), res);";
  "    return res;";
  "}";
  "";
  "// Test whether a variable is bound in a substitution";
  "function is_bound(subst, v) {";
  "    return subst[v] != undefined;";
  "}";
  "";
  "// Binds a variable to another one";
  "function bind(subst, v1, v2) {";
  "    var val = subst[v1];";
  "    if (subst[v1] && (val != v2)) {";
  "        throw \"Already bound\";";
  "    } else {";
  "        subst[v1] = v2;";
  "    }";
  "}";
  "";
  "// Compares two elements (KIND_TYPE_LIST, KIND_TYPE_APP, KIND_VAR, KIND_IDENT)";
  "function equal_element(subst, e1, e2) {";
  "    if ((e1 instanceof Array) && (e2 instanceof Array)) {";
  "        var len = e1.length;";
  "        if (len == e2.length) {";
  "            var i = 0;";
  "            while ((i < len) && (equal_element(subst, e1[i], e2[i]))) {";
  "                i++;";
  "            }";
  "            return (i == len);";
  "        } else {";
  "            return false;";
  "        }";
  "    } else if ((kind(e1) == KIND_VAR) && (kind(e2) == KIND_VAR)) {";
  "        bind(subst, e1, e2);";
  "        return true;";
  "    } else {";
  "        return e1 == e2;";
  "    }";
  "}";
  "";
  "// Compares two coordinates (KIND_FLATTENED_ARROW)";
  "function equal_coordinate(c1, c2) {";
  "    var len = c1.length;";
  "    if (len == c2.length) {";
  "        if (len == 0) return true;";
  "        var subst = new Array();";
  "        try {";
  "            if (!equal_element(subst, c1[len - 1], c2[len - 1])) return false;";
  "        } catch (e) {";
  "            return false;";
  "        }";
  "        if (len == 1) return true;";
  "        var p = permutations(len - 1);";
  "        var n = p.length;";
  "        for (var i = 0; i < n; i++) {";
  "            var j = 0;";
  "            var s = subst.concat([]);";
  "            try {";
  "                while ((j < len - 1) && equal_element(s, c1[j], c2[p[i][j]])) {";
  "                    j++;";
  "                }";
  "                if (j == len - 1) return true;";
  "            } catch (e) {";
  "            }";
  "        }";
  "        return false;";
  "    } else {";
  "        return false;";
  "    }";
  "}";
  "";
  "// Compares two types in normal form (KIND_FLATTENED_PRODUCT)";
  "function equal_normal_form(t1, t2) {";
  "    var len = t1.length;";
  "    if (len == t2.length) {";
  "        if (len == 0) return true;";
  "        var p = permutations(len);";
  "        var n = p.length;";
  "        for (var i = 0; i < n; i++) {";
  "            var j = 0;";
  "            while ((j < len) && equal_coordinate(t1[j], t2[p[i][j]])) {";
  "                j++;";
  "            }";
  "            if (j == len) return true;";
  "        }";
  "        return false;";
  "    } else {";
  "        return false;";
  "    }";
  "}";
]

let generate_files path =
  let filename name = Filename.concat path name in
  Utils.write_lines (filename "argot_parser.js") parser;
  Utils.write_lines (filename "argot_search.js") search;
  Utils.write_lines (filename "argot_types.js") types;

