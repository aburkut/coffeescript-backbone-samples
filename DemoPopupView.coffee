define (require) ->
  PopupView = require 'components/popup/PopupView'

  template = require 'hbars!templates/global/demo/popup'


  class DemoPopupView extends PopupView

    template: template

    hash: '#demo'

    render: ->
      if window.location.hash is @hash
        super()


    onBodyClick: ->


    close: ->
      @publishEvent 'demo:closed'
      super()