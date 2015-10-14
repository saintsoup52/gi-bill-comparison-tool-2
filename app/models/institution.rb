class Institution < ActiveRecord::Base
  belongs_to :institution_type, inverse_of: :institutions

  validates_presence_of :facility_code, :institution, :country, :institution_type_id, :city
  validates_presence_of :state, :zip, if: :in_usa?

  validates_uniqueness_of :facility_code

  validates_inclusion_of :poe, :yr, :student_veteran, :eight_keys, :dodmou, :online_all, 
      :sec_702, :accredited, :hcm_status, in: [true, false]

  def correspondence?
    institution_type.name.downcase == 'correspondence'
  end

  def flight?
    institution_type.name.downcase == 'flight'
  end

  def in_usa?
    country.try(:downcase) == 'usa'
  end
end
