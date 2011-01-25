module Net
 class HTTP < Protocol
   def HTTP.new(address, port = nil, p_addr = 'proxy.globant.com', p_port = 3128, p_user = nil, p_pass = nil)
     if address =~ /127.0.0.1|75.101.132.30|10.20.11.51/
       p_addr = nil
       p_port = nil
     end
     proxy = Proxy(p_addr, p_port, p_user, p_pass).newobj(address, port)
     proxy.instance_eval { @newimpl = ::Net::HTTP.version_1_2? }
     return proxy
   end
 end
end

