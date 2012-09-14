#!/usr/bin/env ruby

require_relative 'example'
require_relative '../lib/google_image_chart'

line_chart_png = GoogleImageChart.new(
  type: "lc:nda",
  axes: %w[x y],
  axes_range: %w[1 0 100 10],
  margins: [%w[10 10 10 10]],
  colours: %w[000000 FF0000],
  line_styles: %w[5 2,5],
  labels: [
    %w[8:00 8:05 8:10 8:15 8:20 8:25 8:30 8:35 8:40 8:45 8:50 8:55 9:00]
  ],
  data: [
    %w[30 20 40 10 30 20 40 50 60 70 90 50 90],
    %w[70 70 70 70 70 70 70 70 70 70 70 70]
  ],
  markers: [
    "N,FF0000,0,9,15",
    "N,FF0000,0,10,15",
    "N,FF0000,0,12,15",
    "v,DDDDDD,0,::1,1,-1"
  ]
)

exemplify("Google Image Chart API url", line_chart.url)

puts "\nOpening generated PNG...\n"

`open "#{line_chart_png.url}"`
