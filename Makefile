.PHONY : test prod build clean

ROOT_DIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))

# Directory containing source (YAML) files
source_dir := $(ROOT_DIR)/src

# Directory containing templated YAML files
output_dir := $(ROOT_DIR)/build

sources := $(wildcard $(source_dir)/*.yaml $(source_dir)/**/*.yaml)

# Convert the list of source files
objects := $(patsubst %.yaml,%.yaml,$(subst $(source_dir),$(output_dir),$(sources)))

default:
	$(info Specify an environment)
	exit 1

# Targets
test: env = test
test: clean build

prod: env = prod
prod: clean build

build: $(objects)

clean:
	$(info Cleaning $(ROOT_DIR)/build)
	@ rm -rf $(ROOT_DIR)/build/

$(output_dir)/%.yaml: $(source_dir)/%.yaml $(ROOT_DIR)/config/images.yaml $(ROOT_DIR)/config/**/variables.yaml
	$(info Processing $<)
	@ mkdir -p $(abspath $(dir $@))
	@ yasha \
		-v $(ROOT_DIR)/config/$(env)/variables.yaml \
		-v $(ROOT_DIR)/config/images.yaml \
		-o $@ \
		$<
