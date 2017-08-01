classdef PacketProcessor
    properties
        hidDevice;
        hidService;
    end
    methods
        function packet = PacketProcessor(deviceID)
            javaaddpath('../lib/hid4java-0.5.0.jar');
            
            import org.hid4java.*;
            import org.hid4java.event.*;
            import java.nio.ByteBuffer;
            import java.nio.ByteOrder;
            import java.lang.*;
            import org.apache.commons.lang.ArrayUtils.*;
            
            if nargin > 0
                packet.hidService = HidManager.getHidServices();
                packet.hidService.start();
                hidDevices = packet.hidService.getAttachedHidDevices();
                dev=hidDevices.toArray;
                
                for k=1:(dev.length)
                    if dev(k).getProductId() == deviceID
                        packet.hidDevice = dev(k);
                    end
                end
            end
        end
        function com = command(packet, idOfCommand, values)
            packetSize = 64;
            numFloats = (packetSize / 4) - 1;
            
            objMessage = javaArray('java.lang.Byte', packetSize);
            tempArray = packet.single2bytes(idOfCommand, values);
            
            for i=1:size(tempArray)
                objMessage(i) = java.lang.Byte(tempArray(i));
            end
            
            message = javaMethod('toPrimitive', 'org.apache.commons.lang.ArrayUtils', objMessage);
            
            returnValues = zeros(numFloats, 1);
            packet.hidDevice.open();
            if packet.hidDevice.isOpen()
                val = packet.hidDevice.write(message, packetSize, 0);
                if val > 0
                    read = packet.hidDevice.read(message, 1000);
                    if read > 0
                        for i=1:len(numFloats)
                            baseIndex = (4 * i) + 4;
                            returnValues(i) = java.nio.ByteBuffer.wrap(message).order(be).getFloat(baseIndex);
                        end
                    else
                        disp("Read failed")
                    end
                else
                    disp("Writing failed")
                end
            end
            
            packet.hidDevice.close()
            packet.hidService.shutdown();
            com = returnValues;
        end
        function thing = single2bytes(packet, code, val)
            newArray = zeros(length(val)+1, 1, 'single');
            for i=1:size(newArray)
                if i == 1
                    newArray(i) = single(code);
                else
                    newArray(i) = val(i-1);
                end
            end
            
            disp(newArray)
            
            returnArray = typecast(newArray, 'uint8');
            thing = returnArray;
        end
    end
end
