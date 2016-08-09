class Dashing.Graph extends Dashing.Widget

  ready: ->
    container = $(@node).parent()
    width = (Dashing.widget_base_dimensions[0] * container.data("sizex")) + Dashing.widget_margins[0] * 2 * (container.data("sizex") - 1)
    height = (Dashing.widget_base_dimensions[1] * container.data("sizey"))
    @graph = new Rickshaw.Graph(
      element: @node
      width: width
      height: height
      renderer: "line"
      max: 50
      min: 0
      series: [
        {
        color: "#ff1919",
        data: [{x:0, y:0}]
        }
      ]
      padding: {top: 0, left: 0, right: 0, bottom: 0}
    )

    @graph.series[0].data = @get('points') if @get('points')

    y_axis = new Rickshaw.Graph.Axis.Y(graph: @graph, tickFormat: Rickshaw.Fixtures.Number.formatKMBT)
    @graph.render()

  onData: (data) ->
    if @graph
      @graph.series[0].data = data.points
      @graph.render()
