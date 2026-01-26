#!/bin/bash

#
# Variables (With Defaults)
#

# Input Args

action="${action:-build}"
firmware="${firmware:-uefi}"
log="${log:-0}"
provider="${provider:-qemu}"
template="${template:-almalinux}"
type="${type:-}"
version="${version:-9}"

## General Vars

## Logging
logs_path="./logs"

export PACKER_LOG=$log

if [[ $log == 1 ]]; then
    export PACKER_LOG=1
fi

#
# Variable Validation
#

case "$provider" in
    vmware-iso|virtualbox-iso|hyperv-iso|qemu)
        printf "%b\n" "Valid provider: ${provider}"
        ;;
    *)
        printf "%b\n" "Invalid provider: ${provider}"
        exit 1
        ;;
esac

#
# Custom Variable Construction
#

var_file="./variables/${template}/${template}-${version}.pkrvars.hcl"
template_file="./templates/${template}/${template}.pkr.hcl"

## If template is windows: adjust var file for firmware
# If Template is Windows-Server - Adjust Var File for Type
if [[ ${template} == "windows" ]]; then
    var_file="./variables/${template}/${template}-${version}-${firmware}.pkrvars.hcl"
    if [[ $type != "" ]]; then
        var_file="./variables/${template}/${template}-${version}-${type}-${firmware}.pkrvars.hcl"
    fi
fi

# If Template is Windows-Server - Adjust Var File for Type
if [[ ${template} == "windows-server" ]]; then
    var_file="./variables/${template}/${template}-${version}-${firmware}.pkrvars.hcl"
    if [[ $type != "" ]]; then
        var_file="./variables/${template}/${template}-${version}-${type}-${firmware}.pkrvars.hcl"
    fi
fi

#
# Debug
#

packer --version

printf "%b\n" "Action: ${action}"

printf "%b\n" "Firmware: ${firmware}"

printf "%b\n" "PACKER_LOG: ${PACKER_LOG}"

printf "%b\n" "Provider: ${provider}"

printf "%b\n" "Template: ${template}"

printf "%b\n" "Template File: ${template_file}"

printf "%b\n" "Type: ${type}"

printf "%b\n" "Variable File: ${var_file}"

printf "%b\n" "Version: ${version}"

# Initialize Logging
mkdir -p "${logs_path}"

packer_log_path="${logs_path}/packerlog-${template}-${version}.txt"

export PACKER_LOG_PATH="${packer_log_path}"

# Init Plugins
packer init "required_plugins.pkr.hcl"

## Get Start Time
start_time=$(date -u +%s.%N)

# Packer Validation
packer validate -var-file="${var_file}" -only="${provider}.${template}" "${template_file}"

# Packer Build

packer build -var-file="${var_file}" -only="${provider}.${template}" --force "${template_file}"

end_time=$(date -u +%s.%N)

elapsed_time=$(echo "$end_time - $start_time" | bc -l)

printf "%b\n" "Elapsed Time: ${elapsed_time} seconds"
