module EnRoute
  module Tokens
    PARAMS     = '(\s+\{\s*\w+\s*:\s*\'?\w+\'?\s*\})?'
    INDENT     = '^(\s*)'
    EOL        = '\s*$'
    METHOD     = '(\s+:\w+)?'
    TO         = '(\w+#\w+)'
    PATH       = '([\w|\/|:]+)'
    AS         = '(\w+|\/)'
    NAME       = '(\w+)'
    SPACE      = '\s'
    SPACES     = '\s+'
    MATCHES    = '(:\s*|get\s+|post\s+|put\s+|delete\s+|)'
    RUBY       = '^ruby:\s*$'
    INCLUDE    = [ INDENT , '@(\w+)', EOL].join
    NAMESPACE  = [ INDENT, 'namespace' , SPACE, NAME, EOL ].join
    MATCH      = [ INDENT, MATCHES, AS, SPACES, TO, SPACES, PATH, PARAMS, EOL ].join
    RESOURCES  = [ INDENT, 'resources' , SPACE, NAME, PARAMS, EOL ].join
    RESOURCE   = [ INDENT, 'resource' , SPACE, NAME, PARAMS, EOL ].join
    COLLECTION = [ INDENT, 'collection' , EOL ].join
    MEMBER     = [ INDENT, 'member', EOL ].join
    POST       = [ INDENT, 'post', SPACES, NAME, EOL ].join
    GET        = [ INDENT, 'get', SPACES, NAME, EOL ].join
    ROOT       = ['^','root',SPACES,TO].join
    BLANK      = '^\s*$'
  end
end
