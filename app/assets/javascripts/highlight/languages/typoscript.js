/*
Language: PHP
Author: Victor Karamzin <Victor.Karamzin@enterra-inc.com>
*/

hljs.LANGUAGES.php = {
  defaultMode: {
    lexems: [hljs.IDENT_RE],
    contains: ['comment', 'number', 'string', 'variable'],
    keywords: {'TEXT': 1, 'IMAGE': 1, '.value': 1}
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
      begin: '\'', end: '\'',
      contains: ['escape'],
      relevance: 0
    },
    {
      className: 'string',
      begin: '"', end: '"',
      contains: ['escape'],
      relevance: 0
    },
    hljs.BACKSLASH_ESCAPE,
    {
      className: 'variable',
      begin: '\[a-zA-Z_\x7f-\xff\.][a-zA-Z0-9_\x7f-\xff]*', end: '^'
    },
    
    {
      className: 'preprocessor',
      begin: '\\?>', end: '^'
    }
  ]
};
