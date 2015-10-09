AtRorSnippetsView = require './at-ror-snippets-view'
{CompositeDisposable} = require 'atom'

module.exports = AtRorSnippets =
  atRorSnippetsView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atRorSnippetsView = new AtRorSnippetsView(state.atRorSnippetsViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atRorSnippetsView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'at-ror-snippets:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atRorSnippetsView.destroy()

  serialize: ->
    atRorSnippetsViewState: @atRorSnippetsView.serialize()

  toggle: ->
    console.log 'AtRorSnippets was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
