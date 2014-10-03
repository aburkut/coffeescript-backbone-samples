define (require) ->
  Model = require 'Model'
  apiRoutes = require 'components/api/apiRoutes'


  class MoneyOrderModel extends Model

    url: apiRoutes 'orders'

    defaults:
      providerId: 'WebMoney'
      amount: null

    validation: ->
      amount: [
        {required: true}
        {min: 200, msg: 'rechargeMin'}
      ]
      providerId:
        required: true


    sync: (method, model, options) ->
      options.attrs =
        afm_pay_order:
          amount: @get 'amount'
          providerId: @get 'providerId'

      super method, model, options
