# Calculating the residence time for multiple receptors 
menu main on

# Load the PSF and DCD files
mol new calc.psf type psf
mol addfile calc.dcd type dcd first 0 last 11300 step 1 waitfor all

# Open a file for writing results
set wrt [open test.txt w]

# Get the total number of frames
set nf [molinfo top get numframes]

# Initialize variables to count contacts for each chain
set total_frames_with_contact 0
set contact_count_A 0
set contact_count_B 0
set contact_count_C 0
set contact_count_D 0

# Loop through frames to analyze contacts
for {set i 0} {$i < $nf} {incr i} {
    # Select atoms in contact with each chain
    set contact_A [atomselect top "chain P and within 3 of (chain A)" frame $i]
    set contact_B [atomselect top "chain P and within 3 of (chain B)" frame $i]
    set contact_C [atomselect top "chain P and within 3 of (chain C)" frame $i]
    set contact_D [atomselect top "chain P and within 3 of (chain D)" frame $i]

    # Get the number of atoms in contact with each chain
    set number_A [$contact_A num]
    set number_B [$contact_B num]
    set number_C [$contact_C num]
    set number_D [$contact_D num]

    # Check and update counts if there are contacts with each chain
    if {$number_A > 0} {
        set contact_count_A [expr {$contact_count_A + 1}]
        incr total_frames_with_contact
    }
    if {$number_B > 0} {
        set contact_count_B [expr {$contact_count_B + 1}]
        incr total_frames_with_contact
    }
    if {$number_C > 0} {
        set contact_count_C [expr {$contact_count_C + 1}]
        incr total_frames_with_contact
    }
    if {$number_D > 0} {
        set contact_count_D [expr {$contact_count_D + 1}]
        incr total_frames_with_contact
    }
}

# Print the results
puts "Total frames with contact: $total_frames_with_contact"
puts "Total contact count with chain A: $contact_count_A"
puts "Total contact count with chain B: $contact_count_B"
puts "Total contact count with chain C: $contact_count_C"
puts "Total contact count with chain D: $contact_count_D"

close $wrt

exit
