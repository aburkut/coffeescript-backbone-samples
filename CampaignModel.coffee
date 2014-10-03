define (require) ->
  Model = require 'Model'
  RowModel = require 'components/table/statistics/RowModel'
  apiRoutes = require 'components/api/apiRoutes'


  class CampaignModel extends RowModel

    cache: {}

    url: apiRoutes 'campaigns'

    urlMap:
      budgetAll: 'budget'
      budgetDaily: 'budget_daily'
      price: 'price'

    paramMap:
      budgetAll: 'budget'
      budgetDaily: 'budget'
      price: 'price'


    initialize: ->
      @target = new Model


    set: (key, value) ->
      if _.isString(key)
        if key is 'target'
          @target.set value

      else if _.isObject key
        if key.target
          @target.set key.target
          delete key.target

        super


    validation: ->
      budgetAll:
        required: true
      budgetDaily:
        required: true
      price:
        required: true


    hasBanners: ->
      if @get('bannersCount') > 0 then true
      else false


    isBudgetAvailable: ->
      @get 'availableBudget'


    isBudgetDailyAvailable: ->
      @get 'availableBudgetDaily'


    saveAttr: (attr, value, options) ->
      paramName = @paramMap[attr]

      data = {}
      data["#{paramName}"] = value

      @sync 'update', @,
        url: _.result(@, 'url') + '/' + @urlMap[attr]
        attrs: data
        success: -> options.success.call null, [value]
