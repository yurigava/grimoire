# from https://github.com/jfromaniello/joseoncodecom/raw/master/_plugins/tag_gen.rb
module Jekyll
  class TagIndex < Page
    def initialize(site, base, dir, tag)
      @site = site
      @base = base
      @dir = "../"
      @name = dir + '.html'

      self.process(@name)
	  if tag == 'abjuration' or tag == 'conjuration' or tag == 'divination' or tag == 'enchantment' or tag == 'evocation' or tag == 'illusion' or tag == 'necromancy' or tag == 'transmutation'
		  self.read_yaml(File.join(base, '_layouts'), 'school_index.html')
	  else
		  self.read_yaml(File.join(base, '_layouts'), 'tag_index.html')
	  end
      self.data['tag'] = tag
      self.data['title'] = tag.capitalize
    end
  end

  class TagGenerator < Generator
    safe true
    def generate(site)
      if site.layouts.key? 'tag_index' or site.layouts.key? 'school_index'
        dir = site.config['tag_dir'] || 'tags'
        site.tags.keys.each do |tag|
          write_tag_index(site, File.join(dir, tag), tag)
        end
      end
    end
    def write_tag_index(site, dir, tag)
      index = TagIndex.new(site, site.source, dir, tag)
      index.render(site.layouts, site.site_payload)
      index.write(site.dest)
      site.pages << index
    end
  end
end
