# Gpdb Client

The gem is a simple wrapper around NameCoach GPDB (General Pronunciation Database) Web API.
You can use this to quickly and easily add NameCoach services to an application's back end services. 

For more information on NameCoach GPDB APi, you can visit [the documentation page](https://namecoachgpdb.docs.apiary.io/#).

- [Installation](#installation)
- [Usage](#usage)
- [API](#api)
  - [Pronunciations](#pronunciations)
    - [Simple search](#simple-search)
    - [Complex search](#complex-search)
    - [Create](#create-a-pronunciation)
  - [Recording requests](#recording-request)
    - [Create](#create-recording-request)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gpdb_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gpdb_client

#### Required ENV variables:

`GPDB_API_URL`

`GPDB_NAMESPACE` - specifies the API version (e.g. `'/api/public/v1'`)

`GPDB_ACCESS_KEY_ID`, `GPDB_SECRET_ACCESS_KEY` - 
During your API onboarding with NameCoach, you will be given these values

## Usage

You need to create a client instance to perform requests. Here's a basic example:

    gpdb_client = Gpdb::REST::Client.new
    
    result = gpdb_client.pronunciations.simple_search(target: 'Alex', app_sig: 'app_sig', app_type: 'app_type')

    # Each response has common methods:
    result.success? # => true
    result.status   # => 200
    
    # As well as specific response attributes
    result.target   # => Gpdb::REST::Pronunciation::Target instance


The client instance contains two resources: `pronunciations` and `recording_requests`.
Each resource has its own methods which are described below. 

You can find detailed information about all the possible parameters and the response format
on the [documentation page](https://namecoachgpdb.docs.apiary.io/#).
Links to the specific methods are placed at the end of each paragraph.

## API

### Pronunciations

#### Simple search

Quick / simple request to get pronunciation for a single target.

    result = gpdb_client.pronunciations.simple_search(
        target: 'Alex',
        app_sig: 'app_sig',
        app_type: 'app_type'
    )
    
    result.meta
    # => Version info for various internal services, mostly useful should you require help from NameCoach's support engineers.
    
    result.target
    # => Gpdb::REST::Pronunciation::Target instance that contains target attributes
    
    pronunciations = result.target.pronunciations
    # => an array of Gpdb::REST::Pronunciation::Model instances
    
    pronunciations.first.audio_url
    # => a link to an audio
    
[Simple search documentation](https://namecoachgpdb.docs.apiary.io/#reference/pronunciations/simple-search/simple-search)

#### Complex search

Perform a GPDB search in for multiple targets.  Currently you can specify up to 10 targets in a single request.

    result = gpdb_client.pronunciations.complex_search(
        targets: [
            {
              target: "praveen",
              target_type_sig:  "person_first_name"
            },
            {
              target: "rob",
              target_type_sig:  "person_first_name"
            },
            {
              target: "green",
              target_type_sig:  "person_last_name"
            }
        ],
        application_context: {
            app_type_sig: "myCoolApp",
            instance_sig: "anInstanceID"
        }
    )
    
    result.target_results
    # => an array of Gpdb::REST::Pronunciation::Target instances
    
    result.meta
    # => Name Parser and Recommendation Model version info
    
[Complex search documentation](https://namecoachgpdb.docs.apiary.io/#reference/pronunciations/complex-search/complex-search)

#### Create a pronunciation

In order to create recordings, audio data must be encoded as base64.

    result = gpdb_client.pronunciations.create(
        name: 'mary',
        target_type_sig: 'person_first_name',
        base64_audio: base64_audio_text,
        application_context: {
            app_type_sig: 'myCoolApp',
            instance_sig: 'anInstanceID'
        },
        user_context: {
            signature: 'u_sign'
        },
        name_owner_context: {
            signature: 'u_name_own'
        }
    )
    
    result.pronunciation
    # => Gpdb::REST::Pronunciation::Model instance
    
    result.errors # will contain errors if attrobutes you provided are not valid
    # => { audio_data: "can't be blank" }

[Create a pronunciation documentation](https://namecoachgpdb.docs.apiary.io/#reference/pronunciations/create-a-pronunciation/create-a-pronunciation)

### Recording request

#### Create recording request

If NameCoach is missing a pronunciation that you need, you can request it:

    result = gpdb_client.recording_requests.create(
        target: 'franka',
        target_type_sig: 'person_first_name',
        target_owner_context: {
            signature: 'sign'
        },
        user_context: {
            signature: 'u_sign'
        },
        application_context: {
            app_type_sig: 'myCoolApp',
            instance_sig: 'anInstanceID'
        }
    )
    
    result.recording_request
    # Gpdb::REST::RecordingRequest::Model instance
    
    result.errors # will contain errors if attributes you provided are not valid
    # => { target: "can't be blank" }

[Recording request documentation](https://namecoachgpdb.docs.apiary.io/#reference/recording-requests/recording-requests/recording-requests)

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
