function initChartCompositionInfo_01(result_date, order_by_date, order_paid_by_date, order_unpaid_by_date, amount_by_date) {
    $('#chart1').highcharts({
      chart: {
        zoomType: 'xy'
      },
      credits: {
        enabled: false
      },
      title: {
        text: 'Thống kê số đơn hàng và doanh thu của cửa hàng'
      },
      subtitle: {
        text: ''
      },
      plotOptions: {
        series: {
          marker: {
            radius: 8
          }
        }
      },
      xAxis: [{
        title: {
          text: 'Tháng',
          style: {
            color: Highcharts.getOptions().colors[1],
            fontSize: '20px'
          }
        },
        categories: result_date,
        crosshair: true,
        labels: {
          style: {
            fontSize: '10px',
            color: '#000'
          }
        }
      }],
      yAxis: [{ // Primary yAxis
        min: Math.min.apply(Math, order_paid_by_date.filter(Number)) - 1,
        allowDecimals: false,
        max: Math.max.apply(null, order_by_date) + 1,
        gridLineColor: '#fff',
        labels: {
          format: '{value}',
          style: {
            color: '#blue',
            fontSize: '14px'
          }
        },
        title: {
          text: '',
          style: {
            color: Highcharts.getOptions().colors[1],
            fontSize: '20px'
          }
        }
      }, { // Secondary yAxis
        title: {
          text: '',
          style: {
            color: Highcharts.getOptions().colors[0],
            fontSize: '19px'
          }
        },
        min: 60,
        gridLineColor: '#fff',
        labels: {
          format: '{value} (VNĐ)',
          style: {
            color: '#333',
            fontSize: '14px'
          }
        },
        opposite: true
      }],
      tooltip: {
        shared: true
      },
      legend: {
        layout: 'vertical',
        align: 'left',
        x: 120,
        enabled: false,
        verticalAlign: 'top',
        y: 100,
        floating: true,
        backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'
      },
      series: [{
        name: 'Số đơn hàng',
        color: 'blue',
        type: 'column',
        data: order_by_date,
        tooltip: {
          valueSuffix: ''
        }
      }, {
        name: 'Thanh toán trực tuyến',
        color: 'green',
        type: 'column',
        data: order_paid_by_date,
        tooltip: {
          valueSuffix: ''
        }
      }, {
        name: 'Thanh toán sau',
        color: 'red',
        type: 'column',
        data: order_unpaid_by_date,
        tooltip: {
          valueSuffix: ''
        }
      }, {
        name: 'Doanh thu',
        type: 'line',
        color: '#333',
        borderColor: '#000000',
        borderWidth: '5',
        yAxis: 1,
        data: amount_by_date,
        tooltip: {
          valueSuffix: ' (VNĐ)'
        }
      }
    ]
    });
  }

  function getDataChartServer(){
    $.ajax({
      type: "GET",
      url: "/statistical/",
      dataType: "json",
      success: function(data){
        order_by_date = data.order_by_date;
        order_paid_by_date = data.order_paid_by_date;
        order_unpaid_by_date = data.order_unpaid_by_date;
        amount_by_date = data.amount_by_date;
        result_date = data.result_date;
        console.log(order_by_date);
        console.log(order_paid_by_date);
        console.log(order_unpaid_by_date);
        console.log(amount_by_date);
        console.log(result_date);
        initChartCompositionInfo_01(result_date, order_by_date, order_paid_by_date, order_unpaid_by_date, amount_by_date);
      }
    })
  }

  $(document).ready(function(){
    getDataChartServer();
  });