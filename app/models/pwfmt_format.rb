class PwfmtFormat < ActiveRecord::Base
  unloadable

  def self.persist(target, field, format)
    pwfmt = PwfmtFormat.where(target_id: target.id, field: field).first
    if pwfmt
      pwfmt.update_attributes(format: format)
    else
      PwfmtFormat.create(target_id: target.id, field: field, format: format)
    end
  end
end
