class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :stars, :comfort, :chef, :area_name, :district_name

  def area_name
    object.area.name
  end

  def district_name
    object.district.name
  end
end
