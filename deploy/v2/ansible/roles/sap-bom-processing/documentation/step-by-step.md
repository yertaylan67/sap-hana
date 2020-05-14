Prerequisite Steps

- Note: SAP Removes files at times when a patched version comes out. This invalidates the ability to Acquire files consistently


-  Maintenance Planner
   - Additional Downloads
    - Stackfile Text File
    - PDF
    - Export to Excel
    - Push to Download Basket
    - Download Stack XML


-  Download Basket

   - Export links to txt file

-  Download Software
  - itterate over linkfile
    - Scan Catalog for url
      - if found record BOM name in Catalog
      - if found make entry in BOM
      - Process next url
    - Download url
      - record filename in catalog
      - upload to storage account with AzCopy Command 

          ```
          export AZCOPY_CRED_TYPE=Anonymous;
          export AZCOPY_USER_AGENT_PREFIX=Microsoft Azure Storage Explorer, 1.12.0, darwin, ;
          ./azcopy copy "/Users/morgandeegan/Downloads/*" "https://zscuslib4ea13ea2fccf9835.blob.core.windows.net/sapbits/sapfiles?<KEY>" --overwrite=prompt --follow-symlinks --recursive --from-to=LocalBlob --blob-type=Detect --list-of-files "/var/folders/l7/w6r335y55pgg0905wyg_mpxc0000gn/T/stg-exp-azcopy-63a13ce4-c565-477b-8ccb-ba407e2a469f.txt" --put-md5;
          unset AZCOPY_CRED_TYPE;
          unset AZCOPY_USER_AGENT_PREFIX;
          ```

      - make entry in BOM
      - Process next url






BOM Processing Steps
- Register BOM
- Create download directories
- Create extraction directories
- Download files
- Extract SAPCAR
- Extract RAR
- Extract ZIP


