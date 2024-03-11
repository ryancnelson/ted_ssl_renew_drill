#!/bin/bash

#x=$1 ; 
#echo x is $1 ; 
#exit

check_expiration() {
    local input_string="$1"
    local date_pattern="notAfter=([A-Za-z]{3} [0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2} [0-9]{4} GMT)"
    
    if [[ $input_string =~ $date_pattern ]]; then
        # Extract the date part from the string
        local date_str="${BASH_REMATCH[1]}"
        
        # Convert the date to a Unix timestamp
        local expiry_date=$(gdate -ud "$date_str" +%s)
        
        # Get the current date and add 60 days, convert to Unix timestamp
        local current_date=$(gdate +%s)
        local sixty_days=$((60 * 24 * 60 * 60)) # 60 days in seconds
        local threshold_date=$((current_date + sixty_days))
        
        # Compare the expiry date with the threshold date
        if [ $expiry_date -lt $threshold_date ]; then
            echo "EXPIRES SOON"
        else
            echo "VALID"
        fi
    else
        echo "Invalid input format"
    fi
}

# Example usage:
##check_expiration "notAfter=Mar 12 20:08:08 2024 GMT"
echo input is __ $1 __ 
check_expiration "$1"
