require 'rexml/document'

class Sly::WorkflowUtils
  def self.array_to_xml(array)
    raise "Argument must be an Array" unless array.kind_of? Array

    doc = REXML::Document.new
    root = doc.add_element("items")
    for entry in array
      item = root.add_element("item")
      entry.each do |key, value|
        if [:uid, :arg, :valid, :autocomplete].include?(key)
          item.attributes[key.to_s] = value.to_s
        else
          element = item.add_element(key.to_s)
          element.text = value ? value.to_s : ""
        end
      end
    end
    #puts "HEllo #{doc.to_s}"

    doc.to_s
  end

  def self.item(uid, arg, title, subtitle, icon="icon.png", valid="yes", autocomplete="")
    return {
      uid:uid, 
      arg:arg,
      title:title,
      subtitle:subtitle,
      icon:icon,
      valid:valid,
      autocomplete:autocomplete
    }
  end

  def self.autocomplete_item(title, subtitle, autocomplete, icon="icon.png")
    return {
      uid:Time.now.to_f.to_s.sub(/\./, ""),
      arg:"",
      title:title,
      subtitle:subtitle,
      icon:icon,
      valid:"no",
      autocomplete:autocomplete
    }
  end

  def self.empty_item
    self.autocomplete_item("No results", "Hit return to clear search", "", "images/task-~.png")
  end

  def self.error_title(error)
    title = error.class.to_s.match(/^Sly::(.+)Error$/)
    title[1].gsub(/([a-z])([A-Z])/, '\1 \2')
  end

  def self.error_item(error)
    self.autocomplete_item(self.error_title(error), error.message, "", "images/defect-~.png")
  end

  def self.error_notification(error)
    "ERROR: #{self.error_title(error)}\n#{error.message}"
  end

  def self.results_feed(items)
    unless items.empty? || items.first.kind_of?(Hash)
      items.map! { |item| item.alfred_result }
    end

    self.array_to_xml(items)
  end
end
