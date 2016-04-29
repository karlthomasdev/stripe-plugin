require 'erb'

module SimpleStripePlugin
  class Form < ::Liquid::Tag

    def initialize(tag_name, markup, tokens, context)
      @options = {
        name_label: "Name",
        id_number_label: "Identification Number",
        amount_label: "Amount",
        number_label: "Card Number",
        exp_label: "Experation Date",
        cvc_label: "CVC",
        submit_label: "Submit Payment"
      }
      markup.scan(::Liquid::TagAttributes) { |key, value| @options[key.to_sym] = value.gsub(/"|'/, '') }
      super
    end

    def render(context)
      form_start = ERB.new(File.read(File.join(File.dirname(__FILE__), 'form_start.erb'))).result binding
      fields = ERB.new(File.read(File.join(File.dirname(__FILE__), 'fields.erb'))).result binding
      form_end = ERB.new(File.read(File.join(File.dirname(__FILE__), 'form_end.erb'))).result binding
      return form_start + fields + form_end
    end
  end
end

