module.exports =

  start: () ->
    requestAnimationFrame -> # wait for other dom changes
      scopes = atom.config.get('typewriter-wotw.scopes').split(',')
      showGutter = atom.config.get('typewriter-wotw.showGutter')
      showScrollbar = atom.config.get('typewriter-wotw.showScrollbar')
      drawTextLeftAligned = atom.config.get('typewriter-wotw.drawTextLeftAligned')
      enabledForAllScopes = atom.config.get('typewriter-wotw.enabledForAllScopes')
      editor = atom.workspace.getActiveTextEditor()

      if editor isnt undefined # e.g. settings-view
        currentScope = editor.getRootScopeDescriptor().scopes[0]

        if currentScope in scopes or enabledForAllScopes is true
          atom.views.getView(editor).setAttribute('data-typewriter-wotw', true)

          if drawTextLeftAligned is false
            characterWidth = editor.getDefaultCharWidth()
            charactersPerLine = atom.config.get('editor.preferredLineLength')

            editor.setSoftWrapped(true)
            atom.views.getView(editor).style.maxWidth = characterWidth * (charactersPerLine + 6) + 'px'
            atom.views.getView(editor).style.paddingLeft = characterWidth * 2 + 'px'
            atom.views.getView(editor).style.paddingRight = characterWidth * 2 + 'px'

          if showGutter is false
            atom.views.getView(editor).setAttribute('data-typewriter-wotw-hide-gutter', true)

          if showScrollbar is false
            atom.views.getView(editor).setAttribute('data-typewriter-wotw-hide-scrollbar', true)

  stop: () ->
    $ = require 'jquery'
    $('[data-typewriter-wotw]').attr('data-typewriter-wotw', false)
    $('[data-typewriter-wotw]').attr('data-typewriter-wotw-hide-gutter', false)
    $('[data-typewriter-wotw]').attr('data-typewriter-wotw-hide-scrollbar', false)
    $('atom-text-editor:not(.mini)').css 'max-width', ''
