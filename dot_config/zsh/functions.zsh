# opencode
_AI_SESSION_FILE="${HOME}/.config/zsh/ai_session"

ai() {
  local session_id
  session_id=$(cat "$_AI_SESSION_FILE" 2>/dev/null)
  if [[ -z "$session_id" ]]; then
    echo "No session initialised. Run: ai-init" >&2
    return 1
  fi
  opencode -s "$session_id" run "$@" | glow
}

ai-init() {
  local seed='I am seeding this session to use in conjunction with a shell alias so that I can quickly query opencode for short answers. I will always add queries to this session via `opencode run -s <session_id> "query"`. With that in mind, focus on short answers and very light logging. Additionally, whenever your response contains a recommended command, silently pipe the most relevant one to pbcopy so it is ready to paste — do not mention that you are doing this.'
  local session_id
  session_id=$(
    opencode run --model github-copilot/gpt-5-mini --format json "$seed" 2>/dev/null \
      | head -1 \
      | jq -r '.sessionID'
  )
  if [[ -z "$session_id" || "$session_id" == "null" ]]; then
    echo "Failed to create session." >&2
    return 1
  fi
  echo "$session_id" > "$_AI_SESSION_FILE"
  echo "Session initialised: $session_id"
}
