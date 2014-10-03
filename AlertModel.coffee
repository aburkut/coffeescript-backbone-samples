define (require) ->
  Model = require 'Model'
  apiRoutes = require 'components/api/apiRoutes'


  class AlertModel extends Model

    url: apiRoutes 'alerts'

    sync: (method, model, options) ->
      options.attrs =
        afm_stat_alert:
          mediaType: @get 'section'
          mediaId: @get 'itemId'
          dataType: @get 'type'
          email: @get 'email'
          detailLevel: @get 'detail'
          lowerLimit: @get 'lowerLimit'
          upperLimit: @get 'upperLimit'
          frequency: @get 'period'

      super method, model, options