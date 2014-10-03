define (require) ->
  Backbone = require 'Backbone'
  RowModel = require 'components/table/statistics/RowModel'
  apiRoutes = require 'components/api/apiRoutes'
  _ = require '_'


  class SiteModel extends RowModel

    cache: {}

    url: apiRoutes 'sites'

    rejectedStates: ['forbidden', 'wait', 'verification']

    defaults:
      type: 'web'
      name: null
      host: null
      appLink: null
      bannerCategories: []

    validation: ->
      type = @get 'type'

      name:
        required: type is 'android'

      appLink:
        required: type is 'android'

      host:
        required: type is 'web'
        domainOrIp: true

      type:
        required: true

      bannerCategories: (value) ->
        if not value or not value.length
          'bannerCategoriesRequired'

    sync: (method, model, options) ->

      if @isNew()
        options.attrs =
          afm_site_new:
            type: @get 'type'
            name: @get 'name'
            appLink: @get 'appLink'
            host: @get 'host'
            bannerCategories: @get 'bannerCategories'
      else
        options.attrs =
          afm_site_edit:
            bannerCategories: @get 'bannerCategories'
            excludeWords: @get 'excludeWords'

        if @get('type') is 'android'
          options.attrs.afm_site_edit.name = @get 'name'
          options.attrs.afm_site_edit.appLink = @get 'appLink'
        else
          options.attrs.afm_site_edit.host = @get 'host'


      super method, model, options


    verify: ->
      Backbone.ajax(apiRoutes('site_verify')({site: @id})).success =>
        @fetch()


    changeState: (state, isUpdate) ->
      url = apiRoutes('sites_state')
      @sync 'update', @,
        url: url()
        contentType: 'application/json'
        data: JSON.stringify {ids: @id, state: state}

        success: =>
          @set 'state', state

        error: (res) =>
          @publishEvent 'global-notification', { type: 'error', message: res.responseJSON.errors.message }


    isRejected: ->
      state = @get 'state'
      _.indexOf(@rejectedStates, state) > -1


    getStats: (statName) ->
      if not @isRejected()
        metrics = @get('metrics')
        if not metrics
          return 0
        else
          stat = metrics[statName]
          if not stat then 0
          else parseInt stat
      else - 1
