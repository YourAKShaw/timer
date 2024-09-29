#!/bin/zsh

# Function to display usage if incorrect input
function usage {
    echo "Usage: timer [a H] [b M] [c S]"
    echo "Example: timer 1 H 30 M 10 S"
    exit 1
}

# Check if no arguments are passed
if [ $# -eq 0 ]; then
    usage
fi

# Initialize time variables
hours=0
minutes=0
seconds=0

# Parse the arguments
while [[ $# -gt 0 ]]; do
    case "$2" in
        H)
            hours=$1
            shift 2
            ;;
        M)
            minutes=$1
            shift 2
            ;;
        S)
            seconds=$1
            shift 2
            ;;
        *)
            usage
            ;;
    esac
done

# Convert to total seconds
total_seconds=$((hours * 3600 + minutes * 60 + seconds))

# Function to convert seconds into H:M:S format
format_time() {
    local t=$1
    local h=$((t / 3600))
    local m=$(((t % 3600) / 60))
    local s=$((t % 60))
    printf "%02d:%02d:%02d" $h $m $s
}

# Function to play an alarm sound
play_alarm() {
    # Default system beep (can replace with custom sound)
    echo -e "\a"
    
    # Uncomment the next line to use a custom sound file (requires `mpg123` or `aplay`)
    # mpg123 /path/to/your/sound.mp3   # Or aplay /path/to/sound.wav
}

# Function to create a simple ASCII art countdown
display_ascii_countdown() {
    for ((i = $total_seconds; i >= 0; i--)); do
        clear
        echo "============================="
        echo "         TIMER ACTIVE        "
        echo "============================="
        echo ""
        echo "          $(format_time $i)  "
        echo ""
        echo "============================="
        echo "    Press Ctrl+C to cancel.   "
        echo "============================="
        sleep 1
    done
    clear
    echo "============================="
    echo "         TIME'S UP!           "
    echo "============================="
    echo ""
    echo "          00:00:00           "
    echo ""
    echo "============================="

    # Play the alarm when the timer is done
    play_alarm
}

# Run the timer
echo "Starting timer for $(format_time $total_seconds)"
display_ascii_countdown
