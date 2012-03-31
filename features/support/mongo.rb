conn = Mongo::Connection.new('localhost', 27017)
$db = conn["lovelyromcoms_#{Rails.env}"]