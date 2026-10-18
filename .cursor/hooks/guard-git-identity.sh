#!/bin/sh
# Cursor beforeShellExecution: require privacy identity on git commit / push.
input=$(cat)

# Prefer python for JSON parse (available on this machine); fall back to allow if missing.
command=$(printf '%s' "$input" | python -c "import sys,json; print(json.load(sys.stdin).get('command') or '')" 2>/dev/null || true)

if [ -z "$command" ]; then
  printf '%s\n' '{"permission":"allow"}'
  exit 0
fi

case "$command" in
  *git*commit*|*git*push*)
    ;;
  *)
    printf '%s\n' '{"permission":"allow"}'
    exit 0
    ;;
esac

# Allow commits that already pin the safe identity via -c flags.
case "$command" in
  *user.email=BeanCounter11@users.noreply.github.com*|*user.email=\"BeanCounter11@users.noreply.github.com\"*|*user.email='BeanCounter11@users.noreply.github.com'*)
    printf '%s\n' '{"permission":"allow"}'
    exit 0
    ;;
esac

# Allow push; pre-push hook enforces commit metadata.
case "$command" in
  *git*push*)
    printf '%s\n' '{"permission":"allow"}'
    exit 0
    ;;
esac

printf '%s\n' '{"permission":"deny","user_message":"Commit blocked: use GitHub handle + noreply email only.","agent_message":"Denied git commit without privacy identity. Re-run as: git -c user.name=\"BeanCounter11\" -c user.email=\"BeanCounter11@users.noreply.github.com\" commit ... Do not use a personal name or email."}'
exit 0
