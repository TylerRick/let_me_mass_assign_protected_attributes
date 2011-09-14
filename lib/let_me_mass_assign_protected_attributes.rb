require "let_me_mass_assign_protected_attributes/version"

module LetMeMassAssignProtectedAttributes
  extend ActiveSupport::Concern

  def unprotected_attributes=(attributes)
    self.tap do
      attributes.each do |key, value|
        self.send "#{key}=", value
      end
    end
  end

  # update_attributes doesn't set attributes protected via attr_protected (instead, it logs a warning informing you that you are trying to mass-assign protected attributes), so this method is convenient if you have a hash of protected attributes that you want to set
  def unprotected_update_attributes(attributes)
    self.tap do
      self.unprotected_attributes = attributes
      save
    end
  end

  # Updates an object just like Base.unprotected_update_attributes but calls save! instead of save so an exception is raised if the record is invalid.
  def unprotected_update_attributes!(attributes)
    self.tap do
      self.unprotected_attributes = attributes
      save!
    end
  end

  module ClassMethods
    # The same as a normal new, only it lets you initialize/set attr_protected attributes
    def unprotected_new(attributes = {})
      if attributes.is_a?(Array)
        attributes.each {|attributes| unprotected_new(attributes) }
      else
        new.tap {|_| _.unprotected_attributes = attributes }
      end
    end

    # The same as a normal create, only it lets you initialize/set attr_protected attributes
    def unprotected_create(attributes = {})
      if attributes.is_a?(Array)
        attributes.each {|attributes| unprotected_create(attributes) }
      else
        new.unprotected_update_attributes(attributes)
      end
    end

    def unprotected_create!(attributes = {})
      if attributes.is_a?(Array)
        attributes.each {|attributes| unprotected_create!(attributes) }
      else
        new.unprotected_update_attributes!(attributes)
      end
    end
  end
end

ActiveRecord::Base.class_eval do
  include LetMeMassAssignProtectedAttributes
end
