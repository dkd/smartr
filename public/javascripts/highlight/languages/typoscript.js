/*
Language: TypoScript
Author: Kieran Hayes <kieran.hayes@dkd.de>
*/

hljs.LANGUAGES.typoscript = {
  defaultMode: {
    lexems: [hljs.IDENT_RE],
    contains: ['comment', 'number', 'string', 'variable'],
    keywords: {'TEXT': 100, 'IMAGE': 1, 'PAGE': 10, 'value': 5,'insertData': 10, 'wrap': 10, 'wrap2': 10}
  },
  case_insensitive: true,
  modes: [
    hljs.C_LINE_COMMENT_MODE,
    hljs.HASH_COMMENT_MODE,
    {
      className: 'comment',
      begin: '/\\*', end: '\\*/',
      contains: ['phpdoc']
    },
    {
      className: 'phpdoc',
      begin: '\\s@[A-Za-z]+', end: '^',
      relevance: 10
    },
    hljs.C_NUMBER_MODE,
    {
      className: 'string',
      begin: '[\d\w+]', end: '=',
      contains: ['escape'],
      relevance: 10
    },
    {
      className: 'string',
      begin: '"', end: '= ',
      contains: ['escape'],
      relevance: 0
    },
    {
      className: 'string',
      begin: '^', end: '=',
      contains: ['escape'],
      relevance: 0
    },
    hljs.BACKSLASH_ESCAPE,
    {
      className: 'variable',
      begin: '^[\d\w+](.*)', end: '='
    },
    
  ]
};
