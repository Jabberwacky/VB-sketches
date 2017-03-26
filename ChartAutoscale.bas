Friend Sub ChartAutoscale()
        Dim VStart, VEnd As Integer
        Dim YMax, YMin As Double
        
        'In my case the X-axis directed from right to the left. Zero point is situated on the right side of the charting area
        'XValues is indexed.
        With ctr.Chart_History
            VStart = .ChartAreas(0).AxisX.ScaleView.ViewMinimum     'Index of right most visible value
            VEnd = .ChartAreas(0).AxisX.ScaleView.ViewMaximum       'Index of left most visible value
            
            'An array of HIGH-values of the visible stock candles chart
            Dim HIGHs() As Double =
                .Series(0).Points.Where(Function(x As DataVisualization.Charting.DataPoint, idx As Integer) idx >= VStart And idx <= VEnd).Select(Function(x As DataVisualization.Charting.DataPoint) x.YValues(0)).ToArray
            'An array of LOW-values of the visible stock candles chart
            Dim LOWs() As Double =
                .Series(0).Points.Where(Function(x As DataVisualization.Charting.DataPoint, idx As Integer) idx >= VStart And idx <= VEnd).Select(Function(x As DataVisualization.Charting.DataPoint) x.YValues(1)).ToArray
                
            YMax = HIGHs.Max        'Finding the maximum on the visible chart area
            YMin = LOWs.Min         'Minimum -//-
            .ChartAreas(0).AxisY.ScaleView.Position = YMin - 20
            .ChartAreas(0).AxisY.ScaleView.Size = YMax - YMin + 20
        End With
    End Sub