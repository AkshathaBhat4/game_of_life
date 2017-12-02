
$(document).ready ->
  next_generation = undefined
  clear_generation = false
  $('.pattern').on 'click', (e)->
    $('#next_generation').removeClass('disabled')
    id = this.dataset.patternId
    world_id = $('#world_id').val()
    $.ajax
      url: '/update_world/' + id
      data: world_id: world_id
      success: (result) ->
        updateGraph(result)
      cache: false

  $('#start_game').on 'click', ->
    $('#next_generation').addClass('disabled')
    nextGeneration(true)

  $('#next_generation').on 'click', ->
    nextGeneration(false)

  $('#end_game').on 'click', ->
    $('#next_generation').removeClass('disabled')
    clear_generation = true

  nextGeneration = (recur)->
    if clear_generation == true
      clear_generation = false
    else
      world_id = $('#world_id').val()
      console.log world_id
      if world_id
        $.ajax
          url: '/next_generation/'+ world_id
          success: (result) ->
            updateGraph(result)
            if (recur == true)
              next_generation = setTimeout (->
                nextGeneration(true)
                return
                ), 1000
          cache: false
      else
        alert('Please Select Any Pattern To Start The Game')

  updateGraph =  (result)->
    chart.xAxis[0].update({max: result['x_axis']['max'], min: result['x_axis']['min']}, true);
    chart.yAxis[0].update({max: result['y_axis']['max'], min: result['y_axis']['min']}, true);
    chart.series[0].setData(result['data'], true)

    $('#world_id').attr('value', result['world_id'])
    $('#generation_count').attr('value', result['generation_count'])

  chart = new Highcharts.chart 'gof_graph',
    chart:
      type: 'scatter3d'
      width: 800
      height: 800
      options3d:
        enabled: true
        alpha: 0
        beta: 10
        depth: 0
        frame: bottom:
          size: 1
          color: 'rgba(0,0,0,0.05)'
    title: text: ''
    subtitle: text: ''
    yAxis:
      categories: []
      min: -10
      max: 19
      endOnTick: true
      tickInterval: 1
      step: 1
      labels: enabled: true
      title: enabled: false
    xAxis:
      categories: []
      min: -10
      max: 19
      endOnTick: true
      tickInterval: 1
      step: 1
      labels: enabled: true
      title: enabled: false
    tooltip: enabled: false
    legend: enabled: false
    series: [ {
      data: []
      marker:
        symbol: 'square'
        radius: 11
    } ]
