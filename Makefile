md     := src/*.md 
haml   := src/*.haml
sass   := src/*.sass

html   := $(patsubst src/%, out/%, $(patsubst %.haml,%.html,$(wildcard $(haml))))
css    := $(patsubst src/%, out/%, $(patsubst %.sass,%.css,$(wildcard $(sass))))

compile: $(html) $(css)
	@rsync -qa src/js out/
	@rsync -qa src/*html out/

out/%.css: src/%.sass
	@echo '    sass  $<'
	@mkdir -p `dirname $@`
	@sass $< $@

out/%.html: src/%.haml $(md)
	@echo '    haml  $<'
	@mkdir -p `dirname $@`
	@haml -E UTF-8 $< $@

clean:
	@rm -rf out/*

