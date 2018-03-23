require 'csv'
require 'uri'
require 'net/http'
require 'json'
require 'pg'
require 'openssl'
require 'digest/md5'
require 'airrecord'

db=PG.connect(
	"dbname"=>ENV['PGNAME'],
	"user"=>ENV['PGUSER'],
	"password"=>ENV['PGPWD'],
	"host"=>ENV['PGHOST'],
	"port"=>ENV['PGPORT']
)

Airrecord.api_key=ENV['AIRTABLE_KEY']
class Pages < Airrecord::Table
	self.base_key=ENV['AIRTABLE_APP']
	self.table_name='Pages'
end

pages=Pages.all
$stdout.sync=true
print "reading records..."
webpages={}
pages.each do |r|
	print '.'
	if webpages[r[:name]].nil? then
		webpages[r[:name]]={
			r[:field]=>{
				'id'=>r.id,
				'text'=>r[:text],
				'attachments'=>r[:attachments]
			}
		} 
	else
		webpages[r[:name]][r[:field]]={
			'id'=>r.id,
			'text'=>r[:text],
			'attachments'=>r[:attachments]
		}
	end
end
puts "OK"
print "reseting website..."
reset="DELETE FROM api.website;"
res=db.exec(reset)
puts "OK"
print "saving records..."
insert="INSERT INTO api.website (page_name,data) VALUES ($1,$2)"
webpages.each do |k,v|
	print '.'
	res=db.exec_params(insert,[k,v.to_json])
end
puts "OK"
