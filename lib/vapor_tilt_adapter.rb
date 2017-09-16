require "vapor_tilt_adapter/version"
require 'json'
require 'fileutils'
require 'English'

module VaporTiltAdapter
  class Renderer

    # Parses context data, sets instance variables, renders the view, and writes it to the specified
    # file.
    #
    # The values for these parameters will typically come straight from TiltRenderer via ARGV.
    # They are:
    # view_dir::          The absolute path to the directory where your views are
    #                     located. The last character should be a +/+.
    # template_filename:: The filename of the template being rendered, including extension.
    # output_path::       The absolute path of the file to which the rendered template will be written.
    # context::           A JSON string containing all the data (primarily the values of instance variables)
    #                     to be used in your templates
    # default_layout::    Either a string containing the filename of the default layout template, or
    #                  +false+ to have the default be to render without a layout.
    def render(view_dir, template_filename, output_path, context, default_layout = false)
      json          = JSON.parse(context, symbolize_names: true) || {}
      json[:layout] = default_layout unless json.key? :layout

      ivars = json.select { |k, _| k[0] == '@' }
      ivars&.each do |k, v|
        instance_variable_set(k, v)
      end

      template = Tilt.new(view_dir + template_filename)

      outstr = if (layout = json[:layout])
                 Tilt.new(view_dir + layout).render(self) { template.render(self) }
               else
                 template.render(self)
               end

      FileUtils.mkdir_p output_path.sub(%r{/[^/]*$}, '')
      File.write(output_path, outstr)
    rescue
      write_error(output_path, $ERROR_INFO)
      raise $ERROR_INFO
    end

    protected

    def write_error(output_path, error)
      File.write(output_path, "<h1>Rendering error: #{CGI.escapeHTML(error.message)}</h1>" \
                                  "<pre>#{CGI.escapeHTML(error.backtrace.join("\n"))}</pre>")
      # TODO: add more debug information in the case of an error
      # TODO: make the presence of debug information be dependent on dev/production environment
    end
  end
end
