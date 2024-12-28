{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {

    environment.systemPackages = with pkgs; [
        (writeShellApplication {
        name = "rebootScript";
        text = ''
            cd ~/Projects/nohl-emacs-files/
            git add .
            git commit -m "Desktop auto-push: $(date)"
            git push
            reboot
            '';
        })
        (writeShellApplication {
            name = "srd";
            text = ''
                while read -r line; do
                    echo "$1$line$2"
                done
            '';
        })

        (writeShellApplication {
            name = "ai";
            text = ''
                search=$*
                tgpt -w "answer the following prompt as concisely as possible: $search"
            '';
        })

        (writeShellApplication {
            name = "chunk";
            text = ''
                search=$*
                tgpt -w "the following is a markdown header containing a task on a to do list. break this taks down into subheadings that contain the substeps needed to get it done. do not return any other text other than the markdown subheadings. do not wrap the returned text in markdown multiline comments. do not number the steps. be as concise as possible. include the original top-level heading. here is the task:$search"
            '';
        })

        (writeShellApplication {
            name = "ochunk";
            text = ''
                search=$*
                tgpt -w "the following is a org-mode header containing a task on a to do list. break this taks down into subheadings that contain the substeps needed to get it done. do not return any other text other than the org-mode subheadings. do not wrap the returned text in markdown multiline comments. do not number the steps. be as concise as possible. include the original top-level heading. here is the task:$search"
            '';
        })

        (writeShellApplication {
            name = "perp";
            text = ''
                if [ "$#" -eq 0 ]; then
                    echo "Usage: $(basename "$0") promt_to_send_to_perplexity"
                    echo ""
                    echo "  Requirements: jq must be installed, and PERPLEXITY_API defined"
                    exit 1
                fi

                function p() {
                    local json_request
                    json_request=$(jq -n \
                        --arg content "$*" \
                        '{
                      "model": "llama-3.1-sonar-large-128k-online",
                      "messages": [
                        { "role": "system",  "content": "Be precise and concise. Provide sources when available." },
                        { "role": "user",  "content": $content }
                      ],
                      "stream": false
                    }')
                    # echo $json_request # uncomment to debug
                    
                    local json_response
                    json_response=$(curl --silent \
                        --request POST \
                        --url https://api.perplexity.ai/chat/completions \
                        --header 'accept: application/json' \
                        --header "authorization: Bearer $PERPLEXITY_API" \
                        --header 'content-type: application/json' \
                        --data "$json_request")
                    # echo $json_response  # uncomment to debug

                    echo "$json_response" | jq --raw-output .choices[0].message.content
                }
                p "$*"
                '';
        })

    ];
}
