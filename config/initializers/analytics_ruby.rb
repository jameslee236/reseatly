Analytics = Segment::Analytics.new({
    write_key: 'RvuaqW5CVjPkb6TBzOsFlSdQ0W2y6SsA',
    on_error: Proc.new { |status, msg| print msg }
})