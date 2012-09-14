require 'uri'
require 'net/http'
require 'base64'

require 'hashie/dash'

class GoogleImageChart < Hashie::Dash
  property :type, default: "lc"; alias :cht :type
  property :width, default: 600
  property :height, default: 200
  property :margins, default: [%w[0 0 0 0]]
  property :colours
  property :axes, default: %w[x]
  property :axes_range
  property :line_styles
  property :labels
  property :label_styles
  property :legend_labels
  property :legend_position, default: "b"; alias :chdlp :legend_position
  property :data
  property :markers

  def url
    URI.escape("#{baseurl}#{properties}")
  end

  def image_data
    Net::HTTP.get(
      URI.parse(url)
    )
  end

  def base64
    Base64.encode64(image_data)
  end

  def properties
    %w[
      cht chs chma chco chxt chxr chls chxl chxs chdl chdlp chd chm
    ].inject([]) { |result, property|
      if value = self.send(property)
        result << "#{property}=#{value}"
      end
      result
    }.join("&")
  end

  def chs
    "#{width}x#{height}"
  end

  def chxt
    axes && axes.join(',')
  end

  def chxr
    axes_range && axes_range.join(',')
  end

  def chd
    result = ''

    first_data_group = data.slice(0,1).flatten
    result << 't:' << first_data_group.join(',')

    all_other_data_groups = data.slice(1,data.size)
    all_other_data_groups &&  all_other_data_groups.map { |values| result << '|' << values.join(',') }

    result
  end

  def chls
    line_styles && line_styles.join('|')
  end

  def chma
    margins && margins.map { |group| group.join(',') }.join('|')
  end

  def chco
    colours && colours.join(',')
  end

  def chm
    markers && markers.join('|')
  end

  def chxl
    labels && labels.each_with_index.inject([]) { |result, (labels, index)|
      result << "#{index}:|#{labels.join('|')}"
    }.join(',')
  end

  def chdl
    legend_labels && legend_labels.join('|')
  end

  def chxs
    label_styles && label_styles.join(',')
  end



  private

    def baseurl
      "http://chart.apis.google.com/chart?"
    end
end
