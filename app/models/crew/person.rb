require "#{Rails.root}/lib/cco/service.rb"

class Crew::Person
  include Mongoid::Document
  include Mongoid::Timestamps

  field :firstname, :type => String
  field :lastname, :type => String
  field :nickname, :type => String
  field :avatar_url, :type => String
  field :cco_id, :type => Integer

  has_many :alarms, :class_name => "Sleep::Alarm"
  belongs_to :place, :class_name => "Sleep::Place"
  
  after_update do
    alarms.each &:save
  end
  
  def self.by_username_or_cco_id(username_or_cc_oid)
    username_or_cc_oid = UpcCode.new(username_or_cc_oid).to_i if username_or_cc_oid =~ /^\d{12}$/
    person = self.where(:username => /^#{username_or_cc_oid}$/i).first
    person = self.where(:cco_id => username_or_cc_oid.to_i).first unless person
    person = Cco::Service.fetch_person(username_or_cc_oid) unless person
    person
  end
  
  alias_method :_avatar_url, :avatar_url
  def avatar_url
    a = _avatar_url
    a = "http://crew.dreamhack.se#{a}" unless a.nil? or a.start_with?("http")
    a
  end
end