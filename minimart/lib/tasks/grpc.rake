namespace :grpc do
  task :protoc do
    out = 'lib'
    proto_path = '../protobuf-definitions'
    options = %W[
      --ruby_out #{out}
      --grpc_out #{out}
      --proto_path #{proto_path}
      #{proto_path}/minifinancier.proto
    ]
    File.delete(*Dir.glob("#{out}/*_pb.rb"))
    sh 'grpc_tools_ruby_protoc', *options
  end
end
