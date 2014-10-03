define (require) ->
  RowsCollection = require 'components/table/statistics/RowsCollection'
  CampaignModel = require 'models/campaigns/CampaignModel'
  FilterTypeModel = require 'models/campaigns/FilterTypeModel'
  FilterModel = require 'components/stats/FilterModel'
  StatisticsModel = require 'components/stats/StatisticsModel'
  apiRoutes = require 'components/api/apiRoutes'


  class CampaignsCollection extends RowsCollection

    model: CampaignModel

    url: apiRoutes 'campaigns'

    section: 'campaign'

    initialize: (models, options) ->
      @filterModel = new FilterModel
      @statisticsModel = new StatisticsModel {section: 'campaign'}, filterModel: @filterModel
      @filterTypeModel = new FilterTypeModel


    getStateWeight: (state) ->
      switch state
        when 'on' then 0
        when 'off' then 1
        when 'pause' then 2
