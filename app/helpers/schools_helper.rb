module SchoolsHelper
  def maps_script
    javascript_include_tag(
      "https://maps.googleapis.com/maps/api/js?key=#{ENV['MAPS_API_KEY']}&callback=initMap",
      defer: true,
      async: true
    )
  end
end
