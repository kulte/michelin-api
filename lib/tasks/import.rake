namespace :import do
  task :all => :environment do
    Rake::Task["import:chicago"].invoke
    Rake::Task["import:san_francisco"].invoke
    Rake::Task["import:new_york_city"].invoke
  end

  task :chicago => :environment do
    uri  = 'http://www.michelintravel.com/michelin-selection/michelin-guide-chicago-2014-2/'
    page = agent.get(uri)
    import_restaurants(:chicago, page)
  end

  task :san_francisco => :environment do
    uri = 'http://www.michelintravel.com/michelin-selection/san-francisco-2014/'
    page = agent.get(uri)
    import_restaurants(:san_francisco, page)
  end

  task :new_york_city => :environment do
    uri = 'http://www.michelintravel.com/michelin-selection/new-york-city-2014/'
    page = agent.get(uri)
    import_restaurants(:new_york_city, page)
  end
end

def agent
  @agent ||= Mechanize.new
end

def to_restaurant_attributes(row, stars, area_id)
  columns = row.children.reject(&:blank?)
  attributes = {
    name: columns[0].text,
    area_id: area_id,
    district_id: District.where(name: district_name_for_area(area_id, columns)).first_or_create.id,
    comfort: columns[3].text.to_i,
    stars: stars
  }
  attributes.merge!(chef: columns[4].text) if stars == 3
  attributes
end

def import_restaurants(area, page)
  %w(one two three).each_with_index do |star, index|
    stars = index + 1
    area_id = Area.find_by_name(area.to_s.titleize).id

    pluralized = 'star'.pluralize(stars)
    node  = page.search("li.#{star}-#{pluralized}").children.first
    link  = Mechanize::Page::Link.new(node, agent, page)
    page  = link.click
    table = page.search('div#inner-tab-content table')
    table.search('tbody tr').find_all.each do |row|
      Restaurant.create to_restaurant_attributes(row, stars, area_id)
    end
  end
end

def district_name_for_area(area_id, columns)
  if area_id == 1
    columns[2].text
  else
    if columns[2].text.blank?
      "#{columns[1].text}"
    else
      "#{columns[1].text} - #{columns[2].text}"
    end
  end
end
