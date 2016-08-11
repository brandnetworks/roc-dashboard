class Dashing.Graph extends Dashing.Widget

  svg = $(@node).find('svg')

  ready: ->
    container = $(@node).parent()
    @graph = new Rickshaw.Graph(
      element: @node
      width: 960
      height: 540
      renderer: "scatterplot"
      min: 0
      series: [
        {
        color: "#ff1919",
        data: [{x:0, y:0}]
        }
      ]
      padding: {top: 0.3, left: 0.05, right: 0.05, bottom: 0.05}
    )

    @graph.series[0].data = @get('points') if @get('points')

    y_axis = new (Rickshaw.Graph.Axis.Y)(
      graph: @graph
      tickFormat: Rickshaw.Fixtures.Number.formatKMBT
      element: document.getElementById('y_axis'))

    line =
      'x1': (d) ->
        x labl.x
      'y1': (d) ->
        y maxY
      'x2': (d) ->
        x labl.x
      'y2': (d) ->
        y minY
    label = svg.selectAll('.labels').data(labels).enter()
    label.append('svg:line').attr('x1', line.x1).attr('y1', line.y1).attr('x2', line.x2).attr('y2', line.y2).attr 'class', 'label-line'


    @graph.render();

  onData: (data) ->
    if @graph
      @graph.series[0].data = @get('points')
      @graph.render()
