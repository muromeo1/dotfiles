# RSpec Testing Conventions

## No Local Variables in Tests

Never assign variables inside `it` blocks. Always use `let` or `let!` blocks instead.

### Bad

```ruby
it 'returns pagy and messages' do
  pagy, messages = subject

  expect(pagy).to be_a(Pagy)
  expect(messages).to eq(mock_messages)
end
```

```ruby
it 'returns success with data' do
  subject
  response_data = JSON.parse(response.body)
  expect(response_data['data']).to be_present
end
```

### Good

```ruby
let(:pagy) { subject.first }
let(:messages) { subject.second }

it 'returns pagy and messages' do
  expect(pagy).to be_a(Pagy)
  expect(messages).to eq(mock_messages)
end
```

```ruby
let(:response_data) { JSON.parse(response.body) }

before { subject }

it 'returns success with data' do
  expect(response_data['data']).to be_present
end
```

## One-Liner Tests

When the content of an `it` block is only `subject`, use a one-liner without text.

### Bad

```ruby
it 'excludes must_not from query' do
  subject
end
```

### Good

```ruby
it { subject }
```

The context description already explains what's being tested.

## No `tap` in `let` Blocks

Never use `tap` to create associated objects within a `let` block. Create separate `let` blocks for each object.

### Bad

```ruby
let!(:message_with_attachment) do
  create(:message, conversation: conversation, status: 'sent').tap do |msg|
    create(:message_attachment, message: msg, url: 'https://example.com/image.png')
  end
end
```

### Good

```ruby
let!(:message_with_attachment) { create(:message, conversation: conversation, status: 'sent') }
let!(:message_attachment) { create(:message_attachment, message: message_with_attachment, url: 'https://example.com/image.png') }
```

## No `map`/`times` for Multiple `let` Blocks

When creating multiple test objects, use explicit `let` blocks for each instead of loops or maps.

### Bad

```ruby
let!(:messages_with_attachments) do
  12.times.map do |i|
    create(:message, conversation: conversation, status: 'sent', created_at: i.hours.ago)
  end
end
let!(:attachments_for_messages) do
  messages_with_attachments.each_with_index.map do |msg, i|
    create(:message_attachment, message: msg, url: "https://example.com/image#{i}.png")
  end
end
```

### Good

```ruby
let!(:message_1) { create(:message, conversation: conversation, status: 'sent', created_at: 1.hour.ago) }
let!(:message_2) { create(:message, conversation: conversation, status: 'sent', created_at: 2.hours.ago) }
let!(:message_3) { create(:message, conversation: conversation, status: 'sent', created_at: 3.hours.ago) }

let!(:attachment_1) { create(:message_attachment, message: message_1, url: 'https://example.com/image1.png') }
let!(:attachment_2) { create(:message_attachment, message: message_2, url: 'https://example.com/image2.png') }
let!(:attachment_3) { create(:message_attachment, message: message_3, url: 'https://example.com/image3.png') }
```

Use 2-3 explicit objects instead of dynamically generating many. This keeps tests readable and explicit.
