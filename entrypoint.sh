#!/usr/bin/env bash

data_dir=${DATA_DIR:-data}
conf_dir=${CONF_DIR:-conf}
output=$(geoipupdate -v -f ${conf_dir}/GeoIP.conf -d ${data_dir} 2>&1)
result=$?

if [[ "${output}" == *"No new updates available"* ]]; then
	echo "👍 GeoIP Database up to date, no action needed."
	exit 0
elif [[ ${result} != 0 ]]; then
	echo "👎 Unexpected geoipupdate error: $result"
	echo "${output}"	
	exit 1
else
	echo "👍 GeoIP Database updated safely."
fi
