DoNotUseAtomView = require './do-not-use-atom-view'
{CompositeDisposable} = require 'atom'

module.exports = DoNotUseAtom =
  doNotUseAtomView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @doNotUseAtomView = new DoNotUseAtomView(state.doNotUseAtomViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @doNotUseAtomView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'do-not-use-atom:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @doNotUseAtomView.destroy()

  serialize: ->
    doNotUseAtomViewState: @doNotUseAtomView.serialize()

  toggle: ->
    console.log 'DoNotUseAtom was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
