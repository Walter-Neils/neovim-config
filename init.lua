
local ____modules = {}
local ____moduleCache = {}
local ____originalRequire = require
local function require(file, ...)
    if ____moduleCache[file] then
        return ____moduleCache[file].value
    end
    if ____modules[file] then
        local module = ____modules[file]
        local value = nil
        if (select("#", ...) > 0) then value = module(...) else value = module(file) end
        ____moduleCache[file] = { value = value }
        return value
    else
        if ____originalRequire then
            return ____originalRequire(file)
        else
            error("module '" .. file .. "' not found")
        end
    end
end
____modules = {
["lualib_bundle"] = function(...) 
local function __TS__ArrayAt(self, relativeIndex)
    local absoluteIndex = relativeIndex < 0 and #self + relativeIndex or relativeIndex
    if absoluteIndex >= 0 and absoluteIndex < #self then
        return self[absoluteIndex + 1]
    end
    return nil
end

local function __TS__ArrayIsArray(value)
    return type(value) == "table" and (value[1] ~= nil or next(value) == nil)
end

local function __TS__ArrayConcat(self, ...)
    local items = {...}
    local result = {}
    local len = 0
    for i = 1, #self do
        len = len + 1
        result[len] = self[i]
    end
    for i = 1, #items do
        local item = items[i]
        if __TS__ArrayIsArray(item) then
            for j = 1, #item do
                len = len + 1
                result[len] = item[j]
            end
        else
            len = len + 1
            result[len] = item
        end
    end
    return result
end

local __TS__Symbol, Symbol
do
    local symbolMetatable = {__tostring = function(self)
        return ("Symbol(" .. (self.description or "")) .. ")"
    end}
    function __TS__Symbol(description)
        return setmetatable({description = description}, symbolMetatable)
    end
    Symbol = {
        asyncDispose = __TS__Symbol("Symbol.asyncDispose"),
        dispose = __TS__Symbol("Symbol.dispose"),
        iterator = __TS__Symbol("Symbol.iterator"),
        hasInstance = __TS__Symbol("Symbol.hasInstance"),
        species = __TS__Symbol("Symbol.species"),
        toStringTag = __TS__Symbol("Symbol.toStringTag")
    }
end

local function __TS__ArrayEntries(array)
    local key = 0
    return {
        [Symbol.iterator] = function(self)
            return self
        end,
        next = function(self)
            local result = {done = array[key + 1] == nil, value = {key, array[key + 1]}}
            key = key + 1
            return result
        end
    }
end

local function __TS__ArrayEvery(self, callbackfn, thisArg)
    for i = 1, #self do
        if not callbackfn(thisArg, self[i], i - 1, self) then
            return false
        end
    end
    return true
end

local function __TS__ArrayFill(self, value, start, ____end)
    local relativeStart = start or 0
    local relativeEnd = ____end or #self
    if relativeStart < 0 then
        relativeStart = relativeStart + #self
    end
    if relativeEnd < 0 then
        relativeEnd = relativeEnd + #self
    end
    do
        local i = relativeStart
        while i < relativeEnd do
            self[i + 1] = value
            i = i + 1
        end
    end
    return self
end

local function __TS__ArrayFilter(self, callbackfn, thisArg)
    local result = {}
    local len = 0
    for i = 1, #self do
        if callbackfn(thisArg, self[i], i - 1, self) then
            len = len + 1
            result[len] = self[i]
        end
    end
    return result
end

local function __TS__ArrayForEach(self, callbackFn, thisArg)
    for i = 1, #self do
        callbackFn(thisArg, self[i], i - 1, self)
    end
end

local function __TS__ArrayFind(self, predicate, thisArg)
    for i = 1, #self do
        local elem = self[i]
        if predicate(thisArg, elem, i - 1, self) then
            return elem
        end
    end
    return nil
end

local function __TS__ArrayFindIndex(self, callbackFn, thisArg)
    for i = 1, #self do
        if callbackFn(thisArg, self[i], i - 1, self) then
            return i - 1
        end
    end
    return -1
end

local __TS__Iterator
do
    local function iteratorGeneratorStep(self)
        local co = self.____coroutine
        local status, value = coroutine.resume(co)
        if not status then
            error(value, 0)
        end
        if coroutine.status(co) == "dead" then
            return
        end
        return true, value
    end
    local function iteratorIteratorStep(self)
        local result = self:next()
        if result.done then
            return
        end
        return true, result.value
    end
    local function iteratorStringStep(self, index)
        index = index + 1
        if index > #self then
            return
        end
        return index, string.sub(self, index, index)
    end
    function __TS__Iterator(iterable)
        if type(iterable) == "string" then
            return iteratorStringStep, iterable, 0
        elseif iterable.____coroutine ~= nil then
            return iteratorGeneratorStep, iterable
        elseif iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            return iteratorIteratorStep, iterator
        else
            return ipairs(iterable)
        end
    end
end

local __TS__ArrayFrom
do
    local function arrayLikeStep(self, index)
        index = index + 1
        if index > self.length then
            return
        end
        return index, self[index]
    end
    local function arrayLikeIterator(arr)
        if type(arr.length) == "number" then
            return arrayLikeStep, arr, 0
        end
        return __TS__Iterator(arr)
    end
    function __TS__ArrayFrom(arrayLike, mapFn, thisArg)
        local result = {}
        if mapFn == nil then
            for ____, v in arrayLikeIterator(arrayLike) do
                result[#result + 1] = v
            end
        else
            for i, v in arrayLikeIterator(arrayLike) do
                result[#result + 1] = mapFn(thisArg, v, i - 1)
            end
        end
        return result
    end
end

local function __TS__ArrayIncludes(self, searchElement, fromIndex)
    if fromIndex == nil then
        fromIndex = 0
    end
    local len = #self
    local k = fromIndex
    if fromIndex < 0 then
        k = len + fromIndex
    end
    if k < 0 then
        k = 0
    end
    for i = k + 1, len do
        if self[i] == searchElement then
            return true
        end
    end
    return false
end

local function __TS__ArrayIndexOf(self, searchElement, fromIndex)
    if fromIndex == nil then
        fromIndex = 0
    end
    local len = #self
    if len == 0 then
        return -1
    end
    if fromIndex >= len then
        return -1
    end
    if fromIndex < 0 then
        fromIndex = len + fromIndex
        if fromIndex < 0 then
            fromIndex = 0
        end
    end
    for i = fromIndex + 1, len do
        if self[i] == searchElement then
            return i - 1
        end
    end
    return -1
end

local function __TS__ArrayJoin(self, separator)
    if separator == nil then
        separator = ","
    end
    local parts = {}
    for i = 1, #self do
        parts[i] = tostring(self[i])
    end
    return table.concat(parts, separator)
end

local function __TS__ArrayMap(self, callbackfn, thisArg)
    local result = {}
    for i = 1, #self do
        result[i] = callbackfn(thisArg, self[i], i - 1, self)
    end
    return result
end

local function __TS__ArrayPush(self, ...)
    local items = {...}
    local len = #self
    for i = 1, #items do
        len = len + 1
        self[len] = items[i]
    end
    return len
end

local function __TS__ArrayPushArray(self, items)
    local len = #self
    for i = 1, #items do
        len = len + 1
        self[len] = items[i]
    end
    return len
end

local function __TS__CountVarargs(...)
    return select("#", ...)
end

local function __TS__ArrayReduce(self, callbackFn, ...)
    local len = #self
    local k = 0
    local accumulator = nil
    if __TS__CountVarargs(...) ~= 0 then
        accumulator = ...
    elseif len > 0 then
        accumulator = self[1]
        k = 1
    else
        error("Reduce of empty array with no initial value", 0)
    end
    for i = k + 1, len do
        accumulator = callbackFn(
            nil,
            accumulator,
            self[i],
            i - 1,
            self
        )
    end
    return accumulator
end

local function __TS__ArrayReduceRight(self, callbackFn, ...)
    local len = #self
    local k = len - 1
    local accumulator = nil
    if __TS__CountVarargs(...) ~= 0 then
        accumulator = ...
    elseif len > 0 then
        accumulator = self[k + 1]
        k = k - 1
    else
        error("Reduce of empty array with no initial value", 0)
    end
    for i = k + 1, 1, -1 do
        accumulator = callbackFn(
            nil,
            accumulator,
            self[i],
            i - 1,
            self
        )
    end
    return accumulator
end

local function __TS__ArrayReverse(self)
    local i = 1
    local j = #self
    while i < j do
        local temp = self[j]
        self[j] = self[i]
        self[i] = temp
        i = i + 1
        j = j - 1
    end
    return self
end

local function __TS__ArrayUnshift(self, ...)
    local items = {...}
    local numItemsToInsert = #items
    if numItemsToInsert == 0 then
        return #self
    end
    for i = #self, 1, -1 do
        self[i + numItemsToInsert] = self[i]
    end
    for i = 1, numItemsToInsert do
        self[i] = items[i]
    end
    return #self
end

local function __TS__ArraySort(self, compareFn)
    if compareFn ~= nil then
        table.sort(
            self,
            function(a, b) return compareFn(nil, a, b) < 0 end
        )
    else
        table.sort(self)
    end
    return self
end

local function __TS__ArraySlice(self, first, last)
    local len = #self
    first = first or 0
    if first < 0 then
        first = len + first
        if first < 0 then
            first = 0
        end
    else
        if first > len then
            first = len
        end
    end
    last = last or len
    if last < 0 then
        last = len + last
        if last < 0 then
            last = 0
        end
    else
        if last > len then
            last = len
        end
    end
    local out = {}
    first = first + 1
    last = last + 1
    local n = 1
    while first < last do
        out[n] = self[first]
        first = first + 1
        n = n + 1
    end
    return out
end

local function __TS__ArraySome(self, callbackfn, thisArg)
    for i = 1, #self do
        if callbackfn(thisArg, self[i], i - 1, self) then
            return true
        end
    end
    return false
end

local function __TS__ArraySplice(self, ...)
    local args = {...}
    local len = #self
    local actualArgumentCount = __TS__CountVarargs(...)
    local start = args[1]
    local deleteCount = args[2]
    if start < 0 then
        start = len + start
        if start < 0 then
            start = 0
        end
    elseif start > len then
        start = len
    end
    local itemCount = actualArgumentCount - 2
    if itemCount < 0 then
        itemCount = 0
    end
    local actualDeleteCount
    if actualArgumentCount == 0 then
        actualDeleteCount = 0
    elseif actualArgumentCount == 1 then
        actualDeleteCount = len - start
    else
        actualDeleteCount = deleteCount or 0
        if actualDeleteCount < 0 then
            actualDeleteCount = 0
        end
        if actualDeleteCount > len - start then
            actualDeleteCount = len - start
        end
    end
    local out = {}
    for k = 1, actualDeleteCount do
        local from = start + k
        if self[from] ~= nil then
            out[k] = self[from]
        end
    end
    if itemCount < actualDeleteCount then
        for k = start + 1, len - actualDeleteCount do
            local from = k + actualDeleteCount
            local to = k + itemCount
            if self[from] then
                self[to] = self[from]
            else
                self[to] = nil
            end
        end
        for k = len - actualDeleteCount + itemCount + 1, len do
            self[k] = nil
        end
    elseif itemCount > actualDeleteCount then
        for k = len - actualDeleteCount, start + 1, -1 do
            local from = k + actualDeleteCount
            local to = k + itemCount
            if self[from] then
                self[to] = self[from]
            else
                self[to] = nil
            end
        end
    end
    local j = start + 1
    for i = 3, actualArgumentCount do
        self[j] = args[i]
        j = j + 1
    end
    for k = #self, len - actualDeleteCount + itemCount + 1, -1 do
        self[k] = nil
    end
    return out
end

local function __TS__ArrayToObject(self)
    local object = {}
    for i = 1, #self do
        object[i - 1] = self[i]
    end
    return object
end

local function __TS__ArrayFlat(self, depth)
    if depth == nil then
        depth = 1
    end
    local result = {}
    local len = 0
    for i = 1, #self do
        local value = self[i]
        if depth > 0 and __TS__ArrayIsArray(value) then
            local toAdd
            if depth == 1 then
                toAdd = value
            else
                toAdd = __TS__ArrayFlat(value, depth - 1)
            end
            for j = 1, #toAdd do
                local val = toAdd[j]
                len = len + 1
                result[len] = val
            end
        else
            len = len + 1
            result[len] = value
        end
    end
    return result
end

local function __TS__ArrayFlatMap(self, callback, thisArg)
    local result = {}
    local len = 0
    for i = 1, #self do
        local value = callback(thisArg, self[i], i - 1, self)
        if __TS__ArrayIsArray(value) then
            for j = 1, #value do
                len = len + 1
                result[len] = value[j]
            end
        else
            len = len + 1
            result[len] = value
        end
    end
    return result
end

local function __TS__ArraySetLength(self, length)
    if length < 0 or length ~= length or length == math.huge or math.floor(length) ~= length then
        error(
            "invalid array length: " .. tostring(length),
            0
        )
    end
    for i = length + 1, #self do
        self[i] = nil
    end
    return length
end

local __TS__Unpack = table.unpack or unpack

local function __TS__ArrayToReversed(self)
    local copy = {__TS__Unpack(self)}
    __TS__ArrayReverse(copy)
    return copy
end

local function __TS__ArrayToSorted(self, compareFn)
    local copy = {__TS__Unpack(self)}
    __TS__ArraySort(copy, compareFn)
    return copy
end

local function __TS__ArrayToSpliced(self, start, deleteCount, ...)
    local copy = {__TS__Unpack(self)}
    __TS__ArraySplice(copy, start, deleteCount, ...)
    return copy
end

local function __TS__ArrayWith(self, index, value)
    local copy = {__TS__Unpack(self)}
    copy[index + 1] = value
    return copy
end

local function __TS__New(target, ...)
    local instance = setmetatable({}, target.prototype)
    instance:____constructor(...)
    return instance
end

local function __TS__InstanceOf(obj, classTbl)
    if type(classTbl) ~= "table" then
        error("Right-hand side of 'instanceof' is not an object", 0)
    end
    if classTbl[Symbol.hasInstance] ~= nil then
        return not not classTbl[Symbol.hasInstance](classTbl, obj)
    end
    if type(obj) == "table" then
        local luaClass = obj.constructor
        while luaClass ~= nil do
            if luaClass == classTbl then
                return true
            end
            luaClass = luaClass.____super
        end
    end
    return false
end

local function __TS__Class(self)
    local c = {prototype = {}}
    c.prototype.__index = c.prototype
    c.prototype.constructor = c
    return c
end

local __TS__Promise
do
    local function makeDeferredPromiseFactory()
        local resolve
        local reject
        local function executor(____, res, rej)
            resolve = res
            reject = rej
        end
        return function()
            local promise = __TS__New(__TS__Promise, executor)
            return promise, resolve, reject
        end
    end
    local makeDeferredPromise = makeDeferredPromiseFactory()
    local function isPromiseLike(value)
        return __TS__InstanceOf(value, __TS__Promise)
    end
    local function doNothing(self)
    end
    local ____pcall = _G.pcall
    __TS__Promise = __TS__Class()
    __TS__Promise.name = "__TS__Promise"
    function __TS__Promise.prototype.____constructor(self, executor)
        self.state = 0
        self.fulfilledCallbacks = {}
        self.rejectedCallbacks = {}
        self.finallyCallbacks = {}
        local success, ____error = ____pcall(
            executor,
            nil,
            function(____, v) return self:resolve(v) end,
            function(____, err) return self:reject(err) end
        )
        if not success then
            self:reject(____error)
        end
    end
    function __TS__Promise.resolve(value)
        if __TS__InstanceOf(value, __TS__Promise) then
            return value
        end
        local promise = __TS__New(__TS__Promise, doNothing)
        promise.state = 1
        promise.value = value
        return promise
    end
    function __TS__Promise.reject(reason)
        local promise = __TS__New(__TS__Promise, doNothing)
        promise.state = 2
        promise.rejectionReason = reason
        return promise
    end
    __TS__Promise.prototype["then"] = function(self, onFulfilled, onRejected)
        local promise, resolve, reject = makeDeferredPromise()
        self:addCallbacks(
            onFulfilled and self:createPromiseResolvingCallback(onFulfilled, resolve, reject) or resolve,
            onRejected and self:createPromiseResolvingCallback(onRejected, resolve, reject) or reject
        )
        return promise
    end
    function __TS__Promise.prototype.addCallbacks(self, fulfilledCallback, rejectedCallback)
        if self.state == 1 then
            return fulfilledCallback(nil, self.value)
        end
        if self.state == 2 then
            return rejectedCallback(nil, self.rejectionReason)
        end
        local ____self_fulfilledCallbacks_0 = self.fulfilledCallbacks
        ____self_fulfilledCallbacks_0[#____self_fulfilledCallbacks_0 + 1] = fulfilledCallback
        local ____self_rejectedCallbacks_1 = self.rejectedCallbacks
        ____self_rejectedCallbacks_1[#____self_rejectedCallbacks_1 + 1] = rejectedCallback
    end
    function __TS__Promise.prototype.catch(self, onRejected)
        return self["then"](self, nil, onRejected)
    end
    function __TS__Promise.prototype.finally(self, onFinally)
        if onFinally then
            local ____self_finallyCallbacks_2 = self.finallyCallbacks
            ____self_finallyCallbacks_2[#____self_finallyCallbacks_2 + 1] = onFinally
            if self.state ~= 0 then
                onFinally(nil)
            end
        end
        return self
    end
    function __TS__Promise.prototype.resolve(self, value)
        if isPromiseLike(value) then
            return value:addCallbacks(
                function(____, v) return self:resolve(v) end,
                function(____, err) return self:reject(err) end
            )
        end
        if self.state == 0 then
            self.state = 1
            self.value = value
            return self:invokeCallbacks(self.fulfilledCallbacks, value)
        end
    end
    function __TS__Promise.prototype.reject(self, reason)
        if self.state == 0 then
            self.state = 2
            self.rejectionReason = reason
            return self:invokeCallbacks(self.rejectedCallbacks, reason)
        end
    end
    function __TS__Promise.prototype.invokeCallbacks(self, callbacks, value)
        local callbacksLength = #callbacks
        local finallyCallbacks = self.finallyCallbacks
        local finallyCallbacksLength = #finallyCallbacks
        if callbacksLength ~= 0 then
            for i = 1, callbacksLength - 1 do
                callbacks[i](callbacks, value)
            end
            if finallyCallbacksLength == 0 then
                return callbacks[callbacksLength](callbacks, value)
            end
            callbacks[callbacksLength](callbacks, value)
        end
        if finallyCallbacksLength ~= 0 then
            for i = 1, finallyCallbacksLength - 1 do
                finallyCallbacks[i](finallyCallbacks)
            end
            return finallyCallbacks[finallyCallbacksLength](finallyCallbacks)
        end
    end
    function __TS__Promise.prototype.createPromiseResolvingCallback(self, f, resolve, reject)
        return function(____, value)
            local success, resultOrError = ____pcall(f, nil, value)
            if not success then
                return reject(nil, resultOrError)
            end
            return self:handleCallbackValue(resultOrError, resolve, reject)
        end
    end
    function __TS__Promise.prototype.handleCallbackValue(self, value, resolve, reject)
        if isPromiseLike(value) then
            local nextpromise = value
            if nextpromise.state == 1 then
                return resolve(nil, nextpromise.value)
            elseif nextpromise.state == 2 then
                return reject(nil, nextpromise.rejectionReason)
            else
                return nextpromise:addCallbacks(resolve, reject)
            end
        else
            return resolve(nil, value)
        end
    end
end

local __TS__AsyncAwaiter, __TS__Await
do
    local ____coroutine = _G.coroutine or ({})
    local cocreate = ____coroutine.create
    local coresume = ____coroutine.resume
    local costatus = ____coroutine.status
    local coyield = ____coroutine.yield
    function __TS__AsyncAwaiter(generator)
        return __TS__New(
            __TS__Promise,
            function(____, resolve, reject)
                local fulfilled, step, resolved, asyncCoroutine
                function fulfilled(self, value)
                    local success, resultOrError = coresume(asyncCoroutine, value)
                    if success then
                        return step(resultOrError)
                    end
                    return reject(nil, resultOrError)
                end
                function step(result)
                    if resolved then
                        return
                    end
                    if costatus(asyncCoroutine) == "dead" then
                        return resolve(nil, result)
                    end
                    return __TS__Promise.resolve(result):addCallbacks(fulfilled, reject)
                end
                resolved = false
                asyncCoroutine = cocreate(generator)
                local success, resultOrError = coresume(
                    asyncCoroutine,
                    function(____, v)
                        resolved = true
                        return __TS__Promise.resolve(v):addCallbacks(resolve, reject)
                    end
                )
                if success then
                    return step(resultOrError)
                else
                    return reject(nil, resultOrError)
                end
            end
        )
    end
    function __TS__Await(thing)
        return coyield(thing)
    end
end

local function __TS__ClassExtends(target, base)
    target.____super = base
    local staticMetatable = setmetatable({__index = base}, base)
    setmetatable(target, staticMetatable)
    local baseMetatable = getmetatable(base)
    if baseMetatable then
        if type(baseMetatable.__index) == "function" then
            staticMetatable.__index = baseMetatable.__index
        end
        if type(baseMetatable.__newindex) == "function" then
            staticMetatable.__newindex = baseMetatable.__newindex
        end
    end
    setmetatable(target.prototype, base.prototype)
    if type(base.prototype.__index) == "function" then
        target.prototype.__index = base.prototype.__index
    end
    if type(base.prototype.__newindex) == "function" then
        target.prototype.__newindex = base.prototype.__newindex
    end
    if type(base.prototype.__tostring) == "function" then
        target.prototype.__tostring = base.prototype.__tostring
    end
end

local function __TS__CloneDescriptor(____bindingPattern0)
    local value
    local writable
    local set
    local get
    local configurable
    local enumerable
    enumerable = ____bindingPattern0.enumerable
    configurable = ____bindingPattern0.configurable
    get = ____bindingPattern0.get
    set = ____bindingPattern0.set
    writable = ____bindingPattern0.writable
    value = ____bindingPattern0.value
    local descriptor = {enumerable = enumerable == true, configurable = configurable == true}
    local hasGetterOrSetter = get ~= nil or set ~= nil
    local hasValueOrWritableAttribute = writable ~= nil or value ~= nil
    if hasGetterOrSetter and hasValueOrWritableAttribute then
        error("Invalid property descriptor. Cannot both specify accessors and a value or writable attribute.", 0)
    end
    if get or set then
        descriptor.get = get
        descriptor.set = set
    else
        descriptor.value = value
        descriptor.writable = writable == true
    end
    return descriptor
end

local function __TS__Decorate(self, originalValue, decorators, context)
    local result = originalValue
    do
        local i = #decorators
        while i >= 0 do
            local decorator = decorators[i + 1]
            if decorator ~= nil then
                local ____decorator_result_0 = decorator(self, result, context)
                if ____decorator_result_0 == nil then
                    ____decorator_result_0 = result
                end
                result = ____decorator_result_0
            end
            i = i - 1
        end
    end
    return result
end

local function __TS__ObjectAssign(target, ...)
    local sources = {...}
    for i = 1, #sources do
        local source = sources[i]
        for key in pairs(source) do
            target[key] = source[key]
        end
    end
    return target
end

local function __TS__ObjectGetOwnPropertyDescriptor(object, key)
    local metatable = getmetatable(object)
    if not metatable then
        return
    end
    if not rawget(metatable, "_descriptors") then
        return
    end
    return rawget(metatable, "_descriptors")[key]
end

local __TS__DescriptorGet
do
    local getmetatable = _G.getmetatable
    local ____rawget = _G.rawget
    function __TS__DescriptorGet(self, metatable, key)
        while metatable do
            local rawResult = ____rawget(metatable, key)
            if rawResult ~= nil then
                return rawResult
            end
            local descriptors = ____rawget(metatable, "_descriptors")
            if descriptors then
                local descriptor = descriptors[key]
                if descriptor ~= nil then
                    if descriptor.get then
                        return descriptor.get(self)
                    end
                    return descriptor.value
                end
            end
            metatable = getmetatable(metatable)
        end
    end
end

local __TS__DescriptorSet
do
    local getmetatable = _G.getmetatable
    local ____rawget = _G.rawget
    local rawset = _G.rawset
    function __TS__DescriptorSet(self, metatable, key, value)
        while metatable do
            local descriptors = ____rawget(metatable, "_descriptors")
            if descriptors then
                local descriptor = descriptors[key]
                if descriptor ~= nil then
                    if descriptor.set then
                        descriptor.set(self, value)
                    else
                        if descriptor.writable == false then
                            error(
                                ((("Cannot assign to read only property '" .. key) .. "' of object '") .. tostring(self)) .. "'",
                                0
                            )
                        end
                        descriptor.value = value
                    end
                    return
                end
            end
            metatable = getmetatable(metatable)
        end
        rawset(self, key, value)
    end
end

local __TS__SetDescriptor
do
    local getmetatable = _G.getmetatable
    local function descriptorIndex(self, key)
        return __TS__DescriptorGet(
            self,
            getmetatable(self),
            key
        )
    end
    local function descriptorNewIndex(self, key, value)
        return __TS__DescriptorSet(
            self,
            getmetatable(self),
            key,
            value
        )
    end
    function __TS__SetDescriptor(target, key, desc, isPrototype)
        if isPrototype == nil then
            isPrototype = false
        end
        local ____isPrototype_0
        if isPrototype then
            ____isPrototype_0 = target
        else
            ____isPrototype_0 = getmetatable(target)
        end
        local metatable = ____isPrototype_0
        if not metatable then
            metatable = {}
            setmetatable(target, metatable)
        end
        local value = rawget(target, key)
        if value ~= nil then
            rawset(target, key, nil)
        end
        if not rawget(metatable, "_descriptors") then
            metatable._descriptors = {}
        end
        metatable._descriptors[key] = __TS__CloneDescriptor(desc)
        metatable.__index = descriptorIndex
        metatable.__newindex = descriptorNewIndex
    end
end

local function __TS__DecorateLegacy(decorators, target, key, desc)
    local result = target
    do
        local i = #decorators
        while i >= 0 do
            local decorator = decorators[i + 1]
            if decorator ~= nil then
                local oldResult = result
                if key == nil then
                    result = decorator(nil, result)
                elseif desc == true then
                    local value = rawget(target, key)
                    local descriptor = __TS__ObjectGetOwnPropertyDescriptor(target, key) or ({configurable = true, writable = true, value = value})
                    local desc = decorator(nil, target, key, descriptor) or descriptor
                    local isSimpleValue = desc.configurable == true and desc.writable == true and not desc.get and not desc.set
                    if isSimpleValue then
                        rawset(target, key, desc.value)
                    else
                        __TS__SetDescriptor(
                            target,
                            key,
                            __TS__ObjectAssign({}, descriptor, desc)
                        )
                    end
                elseif desc == false then
                    result = decorator(nil, target, key, desc)
                else
                    result = decorator(nil, target, key)
                end
                result = result or oldResult
            end
            i = i - 1
        end
    end
    return result
end

local function __TS__DecorateParam(paramIndex, decorator)
    return function(____, target, key) return decorator(nil, target, key, paramIndex) end
end

local function __TS__StringIncludes(self, searchString, position)
    if not position then
        position = 1
    else
        position = position + 1
    end
    local index = string.find(self, searchString, position, true)
    return index ~= nil
end

local Error, RangeError, ReferenceError, SyntaxError, TypeError, URIError
do
    local function getErrorStack(self, constructor)
        if debug == nil then
            return nil
        end
        local level = 1
        while true do
            local info = debug.getinfo(level, "f")
            level = level + 1
            if not info then
                level = 1
                break
            elseif info.func == constructor then
                break
            end
        end
        if __TS__StringIncludes(_VERSION, "Lua 5.0") then
            return debug.traceback(("[Level " .. tostring(level)) .. "]")
        else
            return debug.traceback(nil, level)
        end
    end
    local function wrapErrorToString(self, getDescription)
        return function(self)
            local description = getDescription(self)
            local caller = debug.getinfo(3, "f")
            local isClassicLua = __TS__StringIncludes(_VERSION, "Lua 5.0") or _VERSION == "Lua 5.1"
            if isClassicLua or caller and caller.func ~= error then
                return description
            else
                return (description .. "\n") .. tostring(self.stack)
            end
        end
    end
    local function initErrorClass(self, Type, name)
        Type.name = name
        return setmetatable(
            Type,
            {__call = function(____, _self, message) return __TS__New(Type, message) end}
        )
    end
    local ____initErrorClass_1 = initErrorClass
    local ____class_0 = __TS__Class()
    ____class_0.name = ""
    function ____class_0.prototype.____constructor(self, message)
        if message == nil then
            message = ""
        end
        self.message = message
        self.name = "Error"
        self.stack = getErrorStack(nil, self.constructor.new)
        local metatable = getmetatable(self)
        if metatable and not metatable.__errorToStringPatched then
            metatable.__errorToStringPatched = true
            metatable.__tostring = wrapErrorToString(nil, metatable.__tostring)
        end
    end
    function ____class_0.prototype.__tostring(self)
        return self.message ~= "" and (self.name .. ": ") .. self.message or self.name
    end
    Error = ____initErrorClass_1(nil, ____class_0, "Error")
    local function createErrorClass(self, name)
        local ____initErrorClass_3 = initErrorClass
        local ____class_2 = __TS__Class()
        ____class_2.name = ____class_2.name
        __TS__ClassExtends(____class_2, Error)
        function ____class_2.prototype.____constructor(self, ...)
            ____class_2.____super.prototype.____constructor(self, ...)
            self.name = name
        end
        return ____initErrorClass_3(nil, ____class_2, name)
    end
    RangeError = createErrorClass(nil, "RangeError")
    ReferenceError = createErrorClass(nil, "ReferenceError")
    SyntaxError = createErrorClass(nil, "SyntaxError")
    TypeError = createErrorClass(nil, "TypeError")
    URIError = createErrorClass(nil, "URIError")
end

local function __TS__ObjectGetOwnPropertyDescriptors(object)
    local metatable = getmetatable(object)
    if not metatable then
        return {}
    end
    return rawget(metatable, "_descriptors") or ({})
end

local function __TS__Delete(target, key)
    local descriptors = __TS__ObjectGetOwnPropertyDescriptors(target)
    local descriptor = descriptors[key]
    if descriptor then
        if not descriptor.configurable then
            error(
                __TS__New(
                    TypeError,
                    ((("Cannot delete property " .. tostring(key)) .. " of ") .. tostring(target)) .. "."
                ),
                0
            )
        end
        descriptors[key] = nil
        return true
    end
    target[key] = nil
    return true
end

local function __TS__StringAccess(self, index)
    if index >= 0 and index < #self then
        return string.sub(self, index + 1, index + 1)
    end
end

local function __TS__DelegatedYield(iterable)
    if type(iterable) == "string" then
        for index = 0, #iterable - 1 do
            coroutine.yield(__TS__StringAccess(iterable, index))
        end
    elseif iterable.____coroutine ~= nil then
        local co = iterable.____coroutine
        while true do
            local status, value = coroutine.resume(co)
            if not status then
                error(value, 0)
            end
            if coroutine.status(co) == "dead" then
                return value
            else
                coroutine.yield(value)
            end
        end
    elseif iterable[Symbol.iterator] then
        local iterator = iterable[Symbol.iterator](iterable)
        while true do
            local result = iterator:next()
            if result.done then
                return result.value
            else
                coroutine.yield(result.value)
            end
        end
    else
        for ____, value in ipairs(iterable) do
            coroutine.yield(value)
        end
    end
end

local function __TS__FunctionBind(fn, ...)
    local boundArgs = {...}
    return function(____, ...)
        local args = {...}
        __TS__ArrayUnshift(
            args,
            __TS__Unpack(boundArgs)
        )
        return fn(__TS__Unpack(args))
    end
end

local __TS__Generator
do
    local function generatorIterator(self)
        return self
    end
    local function generatorNext(self, ...)
        local co = self.____coroutine
        if coroutine.status(co) == "dead" then
            return {done = true}
        end
        local status, value = coroutine.resume(co, ...)
        if not status then
            error(value, 0)
        end
        return {
            value = value,
            done = coroutine.status(co) == "dead"
        }
    end
    function __TS__Generator(fn)
        return function(...)
            local args = {...}
            local argsLength = __TS__CountVarargs(...)
            return {
                ____coroutine = coroutine.create(function() return fn(__TS__Unpack(args, 1, argsLength)) end),
                [Symbol.iterator] = generatorIterator,
                next = generatorNext
            }
        end
    end
end

local function __TS__InstanceOfObject(value)
    local valueType = type(value)
    return valueType == "table" or valueType == "function"
end

local function __TS__LuaIteratorSpread(self, state, firstKey)
    local results = {}
    local key, value = self(state, firstKey)
    while key do
        results[#results + 1] = {key, value}
        key, value = self(state, key)
    end
    return __TS__Unpack(results)
end

local Map
do
    Map = __TS__Class()
    Map.name = "Map"
    function Map.prototype.____constructor(self, entries)
        self[Symbol.toStringTag] = "Map"
        self.items = {}
        self.size = 0
        self.nextKey = {}
        self.previousKey = {}
        if entries == nil then
            return
        end
        local iterable = entries
        if iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            while true do
                local result = iterator:next()
                if result.done then
                    break
                end
                local value = result.value
                self:set(value[1], value[2])
            end
        else
            local array = entries
            for ____, kvp in ipairs(array) do
                self:set(kvp[1], kvp[2])
            end
        end
    end
    function Map.prototype.clear(self)
        self.items = {}
        self.nextKey = {}
        self.previousKey = {}
        self.firstKey = nil
        self.lastKey = nil
        self.size = 0
    end
    function Map.prototype.delete(self, key)
        local contains = self:has(key)
        if contains then
            self.size = self.size - 1
            local next = self.nextKey[key]
            local previous = self.previousKey[key]
            if next ~= nil and previous ~= nil then
                self.nextKey[previous] = next
                self.previousKey[next] = previous
            elseif next ~= nil then
                self.firstKey = next
                self.previousKey[next] = nil
            elseif previous ~= nil then
                self.lastKey = previous
                self.nextKey[previous] = nil
            else
                self.firstKey = nil
                self.lastKey = nil
            end
            self.nextKey[key] = nil
            self.previousKey[key] = nil
        end
        self.items[key] = nil
        return contains
    end
    function Map.prototype.forEach(self, callback)
        for ____, key in __TS__Iterator(self:keys()) do
            callback(nil, self.items[key], key, self)
        end
    end
    function Map.prototype.get(self, key)
        return self.items[key]
    end
    function Map.prototype.has(self, key)
        return self.nextKey[key] ~= nil or self.lastKey == key
    end
    function Map.prototype.set(self, key, value)
        local isNewValue = not self:has(key)
        if isNewValue then
            self.size = self.size + 1
        end
        self.items[key] = value
        if self.firstKey == nil then
            self.firstKey = key
            self.lastKey = key
        elseif isNewValue then
            self.nextKey[self.lastKey] = key
            self.previousKey[key] = self.lastKey
            self.lastKey = key
        end
        return self
    end
    Map.prototype[Symbol.iterator] = function(self)
        return self:entries()
    end
    function Map.prototype.entries(self)
        local items = self.items
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = {key, items[key]}}
                key = nextKey[key]
                return result
            end
        }
    end
    function Map.prototype.keys(self)
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = key}
                key = nextKey[key]
                return result
            end
        }
    end
    function Map.prototype.values(self)
        local items = self.items
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = items[key]}
                key = nextKey[key]
                return result
            end
        }
    end
    Map[Symbol.species] = Map
end

local function __TS__MapGroupBy(items, keySelector)
    local result = __TS__New(Map)
    local i = 0
    for ____, item in __TS__Iterator(items) do
        local key = keySelector(nil, item, i)
        if result:has(key) then
            local ____temp_0 = result:get(key)
            ____temp_0[#____temp_0 + 1] = item
        else
            result:set(key, {item})
        end
        i = i + 1
    end
    return result
end

local __TS__Match = string.match

local __TS__MathAtan2 = math.atan2 or math.atan

local __TS__MathModf = math.modf

local function __TS__NumberIsNaN(value)
    return value ~= value
end

local function __TS__MathSign(val)
    if __TS__NumberIsNaN(val) or val == 0 then
        return val
    end
    if val < 0 then
        return -1
    end
    return 1
end

local function __TS__NumberIsFinite(value)
    return type(value) == "number" and value == value and value ~= math.huge and value ~= -math.huge
end

local function __TS__MathTrunc(val)
    if not __TS__NumberIsFinite(val) or val == 0 then
        return val
    end
    return val > 0 and math.floor(val) or math.ceil(val)
end

local function __TS__Number(value)
    local valueType = type(value)
    if valueType == "number" then
        return value
    elseif valueType == "string" then
        local numberValue = tonumber(value)
        if numberValue then
            return numberValue
        end
        if value == "Infinity" then
            return math.huge
        end
        if value == "-Infinity" then
            return -math.huge
        end
        local stringWithoutSpaces = string.gsub(value, "%s", "")
        if stringWithoutSpaces == "" then
            return 0
        end
        return 0 / 0
    elseif valueType == "boolean" then
        return value and 1 or 0
    else
        return 0 / 0
    end
end

local function __TS__NumberIsInteger(value)
    return __TS__NumberIsFinite(value) and math.floor(value) == value
end

local function __TS__StringSubstring(self, start, ____end)
    if ____end ~= ____end then
        ____end = 0
    end
    if ____end ~= nil and start > ____end then
        start, ____end = ____end, start
    end
    if start >= 0 then
        start = start + 1
    else
        start = 1
    end
    if ____end ~= nil and ____end < 0 then
        ____end = 0
    end
    return string.sub(self, start, ____end)
end

local __TS__ParseInt
do
    local parseIntBasePattern = "0123456789aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTvVwWxXyYzZ"
    function __TS__ParseInt(numberString, base)
        if base == nil then
            base = 10
            local hexMatch = __TS__Match(numberString, "^%s*-?0[xX]")
            if hexMatch ~= nil then
                base = 16
                numberString = (__TS__Match(hexMatch, "-")) and "-" .. __TS__StringSubstring(numberString, #hexMatch) or __TS__StringSubstring(numberString, #hexMatch)
            end
        end
        if base < 2 or base > 36 then
            return 0 / 0
        end
        local allowedDigits = base <= 10 and __TS__StringSubstring(parseIntBasePattern, 0, base) or __TS__StringSubstring(parseIntBasePattern, 0, 10 + 2 * (base - 10))
        local pattern = ("^%s*(-?[" .. allowedDigits) .. "]*)"
        local number = tonumber((__TS__Match(numberString, pattern)), base)
        if number == nil then
            return 0 / 0
        end
        if number >= 0 then
            return math.floor(number)
        else
            return math.ceil(number)
        end
    end
end

local function __TS__ParseFloat(numberString)
    local infinityMatch = __TS__Match(numberString, "^%s*(-?Infinity)")
    if infinityMatch ~= nil then
        return __TS__StringAccess(infinityMatch, 0) == "-" and -math.huge or math.huge
    end
    local number = tonumber((__TS__Match(numberString, "^%s*(-?%d+%.?%d*)")))
    return number or 0 / 0
end

local __TS__NumberToString
do
    local radixChars = "0123456789abcdefghijklmnopqrstuvwxyz"
    function __TS__NumberToString(self, radix)
        if radix == nil or radix == 10 or self == math.huge or self == -math.huge or self ~= self then
            return tostring(self)
        end
        radix = math.floor(radix)
        if radix < 2 or radix > 36 then
            error("toString() radix argument must be between 2 and 36", 0)
        end
        local integer, fraction = __TS__MathModf(math.abs(self))
        local result = ""
        if radix == 8 then
            result = string.format("%o", integer)
        elseif radix == 16 then
            result = string.format("%x", integer)
        else
            repeat
                do
                    result = __TS__StringAccess(radixChars, integer % radix) .. result
                    integer = math.floor(integer / radix)
                end
            until not (integer ~= 0)
        end
        if fraction ~= 0 then
            result = result .. "."
            local delta = 1e-16
            repeat
                do
                    fraction = fraction * radix
                    delta = delta * radix
                    local digit = math.floor(fraction)
                    result = result .. __TS__StringAccess(radixChars, digit)
                    fraction = fraction - digit
                end
            until not (fraction >= delta)
        end
        if self < 0 then
            result = "-" .. result
        end
        return result
    end
end

local function __TS__NumberToFixed(self, fractionDigits)
    if math.abs(self) >= 1e+21 or self ~= self then
        return tostring(self)
    end
    local f = math.floor(fractionDigits or 0)
    if f < 0 or f > 99 then
        error("toFixed() digits argument must be between 0 and 99", 0)
    end
    return string.format(
        ("%." .. tostring(f)) .. "f",
        self
    )
end

local function __TS__ObjectDefineProperty(target, key, desc)
    local luaKey = type(key) == "number" and key + 1 or key
    local value = rawget(target, luaKey)
    local hasGetterOrSetter = desc.get ~= nil or desc.set ~= nil
    local descriptor
    if hasGetterOrSetter then
        if value ~= nil then
            error(
                "Cannot redefine property: " .. tostring(key),
                0
            )
        end
        descriptor = desc
    else
        local valueExists = value ~= nil
        local ____desc_set_4 = desc.set
        local ____desc_get_5 = desc.get
        local ____temp_0
        if desc.configurable ~= nil then
            ____temp_0 = desc.configurable
        else
            ____temp_0 = valueExists
        end
        local ____temp_1
        if desc.enumerable ~= nil then
            ____temp_1 = desc.enumerable
        else
            ____temp_1 = valueExists
        end
        local ____temp_2
        if desc.writable ~= nil then
            ____temp_2 = desc.writable
        else
            ____temp_2 = valueExists
        end
        local ____temp_3
        if desc.value ~= nil then
            ____temp_3 = desc.value
        else
            ____temp_3 = value
        end
        descriptor = {
            set = ____desc_set_4,
            get = ____desc_get_5,
            configurable = ____temp_0,
            enumerable = ____temp_1,
            writable = ____temp_2,
            value = ____temp_3
        }
    end
    __TS__SetDescriptor(target, luaKey, descriptor)
    return target
end

local function __TS__ObjectEntries(obj)
    local result = {}
    local len = 0
    for key in pairs(obj) do
        len = len + 1
        result[len] = {key, obj[key]}
    end
    return result
end

local function __TS__ObjectFromEntries(entries)
    local obj = {}
    local iterable = entries
    if iterable[Symbol.iterator] then
        local iterator = iterable[Symbol.iterator](iterable)
        while true do
            local result = iterator:next()
            if result.done then
                break
            end
            local value = result.value
            obj[value[1]] = value[2]
        end
    else
        for ____, entry in ipairs(entries) do
            obj[entry[1]] = entry[2]
        end
    end
    return obj
end

local function __TS__ObjectGroupBy(items, keySelector)
    local result = {}
    local i = 0
    for ____, item in __TS__Iterator(items) do
        local key = keySelector(nil, item, i)
        if result[key] ~= nil then
            local ____result_key_0 = result[key]
            ____result_key_0[#____result_key_0 + 1] = item
        else
            result[key] = {item}
        end
        i = i + 1
    end
    return result
end

local function __TS__ObjectKeys(obj)
    local result = {}
    local len = 0
    for key in pairs(obj) do
        len = len + 1
        result[len] = key
    end
    return result
end

local function __TS__ObjectRest(target, usedProperties)
    local result = {}
    for property in pairs(target) do
        if not usedProperties[property] then
            result[property] = target[property]
        end
    end
    return result
end

local function __TS__ObjectValues(obj)
    local result = {}
    local len = 0
    for key in pairs(obj) do
        len = len + 1
        result[len] = obj[key]
    end
    return result
end

local function __TS__PromiseAll(iterable)
    local results = {}
    local toResolve = {}
    local numToResolve = 0
    local i = 0
    for ____, item in __TS__Iterator(iterable) do
        if __TS__InstanceOf(item, __TS__Promise) then
            if item.state == 1 then
                results[i + 1] = item.value
            elseif item.state == 2 then
                return __TS__Promise.reject(item.rejectionReason)
            else
                numToResolve = numToResolve + 1
                toResolve[i] = item
            end
        else
            results[i + 1] = item
        end
        i = i + 1
    end
    if numToResolve == 0 then
        return __TS__Promise.resolve(results)
    end
    return __TS__New(
        __TS__Promise,
        function(____, resolve, reject)
            for index, promise in pairs(toResolve) do
                promise["then"](
                    promise,
                    function(____, data)
                        results[index + 1] = data
                        numToResolve = numToResolve - 1
                        if numToResolve == 0 then
                            resolve(nil, results)
                        end
                    end,
                    function(____, reason)
                        reject(nil, reason)
                    end
                )
            end
        end
    )
end

local function __TS__PromiseAllSettled(iterable)
    local results = {}
    local toResolve = {}
    local numToResolve = 0
    local i = 0
    for ____, item in __TS__Iterator(iterable) do
        if __TS__InstanceOf(item, __TS__Promise) then
            if item.state == 1 then
                results[i + 1] = {status = "fulfilled", value = item.value}
            elseif item.state == 2 then
                results[i + 1] = {status = "rejected", reason = item.rejectionReason}
            else
                numToResolve = numToResolve + 1
                toResolve[i] = item
            end
        else
            results[i + 1] = {status = "fulfilled", value = item}
        end
        i = i + 1
    end
    if numToResolve == 0 then
        return __TS__Promise.resolve(results)
    end
    return __TS__New(
        __TS__Promise,
        function(____, resolve)
            for index, promise in pairs(toResolve) do
                promise["then"](
                    promise,
                    function(____, data)
                        results[index + 1] = {status = "fulfilled", value = data}
                        numToResolve = numToResolve - 1
                        if numToResolve == 0 then
                            resolve(nil, results)
                        end
                    end,
                    function(____, reason)
                        results[index + 1] = {status = "rejected", reason = reason}
                        numToResolve = numToResolve - 1
                        if numToResolve == 0 then
                            resolve(nil, results)
                        end
                    end
                )
            end
        end
    )
end

local function __TS__PromiseAny(iterable)
    local rejections = {}
    local pending = {}
    for ____, item in __TS__Iterator(iterable) do
        if __TS__InstanceOf(item, __TS__Promise) then
            if item.state == 1 then
                return __TS__Promise.resolve(item.value)
            elseif item.state == 2 then
                rejections[#rejections + 1] = item.rejectionReason
            else
                pending[#pending + 1] = item
            end
        else
            return __TS__Promise.resolve(item)
        end
    end
    if #pending == 0 then
        return __TS__Promise.reject("No promises to resolve with .any()")
    end
    local numResolved = 0
    return __TS__New(
        __TS__Promise,
        function(____, resolve, reject)
            for ____, promise in ipairs(pending) do
                promise["then"](
                    promise,
                    function(____, data)
                        resolve(nil, data)
                    end,
                    function(____, reason)
                        rejections[#rejections + 1] = reason
                        numResolved = numResolved + 1
                        if numResolved == #pending then
                            reject(nil, {name = "AggregateError", message = "All Promises rejected", errors = rejections})
                        end
                    end
                )
            end
        end
    )
end

local function __TS__PromiseRace(iterable)
    local pending = {}
    for ____, item in __TS__Iterator(iterable) do
        if __TS__InstanceOf(item, __TS__Promise) then
            if item.state == 1 then
                return __TS__Promise.resolve(item.value)
            elseif item.state == 2 then
                return __TS__Promise.reject(item.rejectionReason)
            else
                pending[#pending + 1] = item
            end
        else
            return __TS__Promise.resolve(item)
        end
    end
    return __TS__New(
        __TS__Promise,
        function(____, resolve, reject)
            for ____, promise in ipairs(pending) do
                promise["then"](
                    promise,
                    function(____, value) return resolve(nil, value) end,
                    function(____, reason) return reject(nil, reason) end
                )
            end
        end
    )
end

local Set
do
    Set = __TS__Class()
    Set.name = "Set"
    function Set.prototype.____constructor(self, values)
        self[Symbol.toStringTag] = "Set"
        self.size = 0
        self.nextKey = {}
        self.previousKey = {}
        if values == nil then
            return
        end
        local iterable = values
        if iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            while true do
                local result = iterator:next()
                if result.done then
                    break
                end
                self:add(result.value)
            end
        else
            local array = values
            for ____, value in ipairs(array) do
                self:add(value)
            end
        end
    end
    function Set.prototype.add(self, value)
        local isNewValue = not self:has(value)
        if isNewValue then
            self.size = self.size + 1
        end
        if self.firstKey == nil then
            self.firstKey = value
            self.lastKey = value
        elseif isNewValue then
            self.nextKey[self.lastKey] = value
            self.previousKey[value] = self.lastKey
            self.lastKey = value
        end
        return self
    end
    function Set.prototype.clear(self)
        self.nextKey = {}
        self.previousKey = {}
        self.firstKey = nil
        self.lastKey = nil
        self.size = 0
    end
    function Set.prototype.delete(self, value)
        local contains = self:has(value)
        if contains then
            self.size = self.size - 1
            local next = self.nextKey[value]
            local previous = self.previousKey[value]
            if next ~= nil and previous ~= nil then
                self.nextKey[previous] = next
                self.previousKey[next] = previous
            elseif next ~= nil then
                self.firstKey = next
                self.previousKey[next] = nil
            elseif previous ~= nil then
                self.lastKey = previous
                self.nextKey[previous] = nil
            else
                self.firstKey = nil
                self.lastKey = nil
            end
            self.nextKey[value] = nil
            self.previousKey[value] = nil
        end
        return contains
    end
    function Set.prototype.forEach(self, callback)
        for ____, key in __TS__Iterator(self:keys()) do
            callback(nil, key, key, self)
        end
    end
    function Set.prototype.has(self, value)
        return self.nextKey[value] ~= nil or self.lastKey == value
    end
    Set.prototype[Symbol.iterator] = function(self)
        return self:values()
    end
    function Set.prototype.entries(self)
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = {key, key}}
                key = nextKey[key]
                return result
            end
        }
    end
    function Set.prototype.keys(self)
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = key}
                key = nextKey[key]
                return result
            end
        }
    end
    function Set.prototype.values(self)
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = key}
                key = nextKey[key]
                return result
            end
        }
    end
    function Set.prototype.union(self, other)
        local result = __TS__New(Set, self)
        for ____, item in __TS__Iterator(other) do
            result:add(item)
        end
        return result
    end
    function Set.prototype.intersection(self, other)
        local result = __TS__New(Set)
        for ____, item in __TS__Iterator(self) do
            if other:has(item) then
                result:add(item)
            end
        end
        return result
    end
    function Set.prototype.difference(self, other)
        local result = __TS__New(Set, self)
        for ____, item in __TS__Iterator(other) do
            result:delete(item)
        end
        return result
    end
    function Set.prototype.symmetricDifference(self, other)
        local result = __TS__New(Set, self)
        for ____, item in __TS__Iterator(other) do
            if self:has(item) then
                result:delete(item)
            else
                result:add(item)
            end
        end
        return result
    end
    function Set.prototype.isSubsetOf(self, other)
        for ____, item in __TS__Iterator(self) do
            if not other:has(item) then
                return false
            end
        end
        return true
    end
    function Set.prototype.isSupersetOf(self, other)
        for ____, item in __TS__Iterator(other) do
            if not self:has(item) then
                return false
            end
        end
        return true
    end
    function Set.prototype.isDisjointFrom(self, other)
        for ____, item in __TS__Iterator(self) do
            if other:has(item) then
                return false
            end
        end
        return true
    end
    Set[Symbol.species] = Set
end

local function __TS__SparseArrayNew(...)
    local sparseArray = {...}
    sparseArray.sparseLength = __TS__CountVarargs(...)
    return sparseArray
end

local function __TS__SparseArrayPush(sparseArray, ...)
    local args = {...}
    local argsLen = __TS__CountVarargs(...)
    local listLen = sparseArray.sparseLength
    for i = 1, argsLen do
        sparseArray[listLen + i] = args[i]
    end
    sparseArray.sparseLength = listLen + argsLen
end

local function __TS__SparseArraySpread(sparseArray)
    local _unpack = unpack or table.unpack
    return _unpack(sparseArray, 1, sparseArray.sparseLength)
end

local WeakMap
do
    WeakMap = __TS__Class()
    WeakMap.name = "WeakMap"
    function WeakMap.prototype.____constructor(self, entries)
        self[Symbol.toStringTag] = "WeakMap"
        self.items = {}
        setmetatable(self.items, {__mode = "k"})
        if entries == nil then
            return
        end
        local iterable = entries
        if iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            while true do
                local result = iterator:next()
                if result.done then
                    break
                end
                local value = result.value
                self.items[value[1]] = value[2]
            end
        else
            for ____, kvp in ipairs(entries) do
                self.items[kvp[1]] = kvp[2]
            end
        end
    end
    function WeakMap.prototype.delete(self, key)
        local contains = self:has(key)
        self.items[key] = nil
        return contains
    end
    function WeakMap.prototype.get(self, key)
        return self.items[key]
    end
    function WeakMap.prototype.has(self, key)
        return self.items[key] ~= nil
    end
    function WeakMap.prototype.set(self, key, value)
        self.items[key] = value
        return self
    end
    WeakMap[Symbol.species] = WeakMap
end

local WeakSet
do
    WeakSet = __TS__Class()
    WeakSet.name = "WeakSet"
    function WeakSet.prototype.____constructor(self, values)
        self[Symbol.toStringTag] = "WeakSet"
        self.items = {}
        setmetatable(self.items, {__mode = "k"})
        if values == nil then
            return
        end
        local iterable = values
        if iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            while true do
                local result = iterator:next()
                if result.done then
                    break
                end
                self.items[result.value] = true
            end
        else
            for ____, value in ipairs(values) do
                self.items[value] = true
            end
        end
    end
    function WeakSet.prototype.add(self, value)
        self.items[value] = true
        return self
    end
    function WeakSet.prototype.delete(self, value)
        local contains = self:has(value)
        self.items[value] = nil
        return contains
    end
    function WeakSet.prototype.has(self, value)
        return self.items[value] == true
    end
    WeakSet[Symbol.species] = WeakSet
end

local function __TS__SourceMapTraceBack(fileName, sourceMap)
    _G.__TS__sourcemap = _G.__TS__sourcemap or ({})
    _G.__TS__sourcemap[fileName] = sourceMap
    if _G.__TS__originalTraceback == nil then
        local originalTraceback = debug.traceback
        _G.__TS__originalTraceback = originalTraceback
        debug.traceback = function(thread, message, level)
            local trace
            if thread == nil and message == nil and level == nil then
                trace = originalTraceback()
            elseif __TS__StringIncludes(_VERSION, "Lua 5.0") then
                trace = originalTraceback((("[Level " .. tostring(level)) .. "] ") .. tostring(message))
            else
                trace = originalTraceback(thread, message, level)
            end
            if type(trace) ~= "string" then
                return trace
            end
            local function replacer(____, file, srcFile, line)
                local fileSourceMap = _G.__TS__sourcemap[file]
                if fileSourceMap ~= nil and fileSourceMap[line] ~= nil then
                    local data = fileSourceMap[line]
                    if type(data) == "number" then
                        return (srcFile .. ":") .. tostring(data)
                    end
                    return (data.file .. ":") .. tostring(data.line)
                end
                return (file .. ":") .. line
            end
            local result = string.gsub(
                trace,
                "(%S+)%.lua:(%d+)",
                function(file, line) return replacer(nil, file .. ".lua", file .. ".ts", line) end
            )
            local function stringReplacer(____, file, line)
                local fileSourceMap = _G.__TS__sourcemap[file]
                if fileSourceMap ~= nil and fileSourceMap[line] ~= nil then
                    local chunkName = (__TS__Match(file, "%[string \"([^\"]+)\"%]"))
                    local sourceName = string.gsub(chunkName, ".lua$", ".ts")
                    local data = fileSourceMap[line]
                    if type(data) == "number" then
                        return (sourceName .. ":") .. tostring(data)
                    end
                    return (data.file .. ":") .. tostring(data.line)
                end
                return (file .. ":") .. line
            end
            result = string.gsub(
                result,
                "(%[string \"[^\"]+\"%]):(%d+)",
                function(file, line) return stringReplacer(nil, file, line) end
            )
            return result
        end
    end
end

local function __TS__Spread(iterable)
    local arr = {}
    if type(iterable) == "string" then
        for i = 0, #iterable - 1 do
            arr[i + 1] = __TS__StringAccess(iterable, i)
        end
    else
        local len = 0
        for ____, item in __TS__Iterator(iterable) do
            len = len + 1
            arr[len] = item
        end
    end
    return __TS__Unpack(arr)
end

local function __TS__StringCharAt(self, pos)
    if pos ~= pos then
        pos = 0
    end
    if pos < 0 then
        return ""
    end
    return string.sub(self, pos + 1, pos + 1)
end

local function __TS__StringCharCodeAt(self, index)
    if index ~= index then
        index = 0
    end
    if index < 0 then
        return 0 / 0
    end
    return string.byte(self, index + 1) or 0 / 0
end

local function __TS__StringEndsWith(self, searchString, endPosition)
    if endPosition == nil or endPosition > #self then
        endPosition = #self
    end
    return string.sub(self, endPosition - #searchString + 1, endPosition) == searchString
end

local function __TS__StringPadEnd(self, maxLength, fillString)
    if fillString == nil then
        fillString = " "
    end
    if maxLength ~= maxLength then
        maxLength = 0
    end
    if maxLength == -math.huge or maxLength == math.huge then
        error("Invalid string length", 0)
    end
    if #self >= maxLength or #fillString == 0 then
        return self
    end
    maxLength = maxLength - #self
    if maxLength > #fillString then
        fillString = fillString .. string.rep(
            fillString,
            math.floor(maxLength / #fillString)
        )
    end
    return self .. string.sub(
        fillString,
        1,
        math.floor(maxLength)
    )
end

local function __TS__StringPadStart(self, maxLength, fillString)
    if fillString == nil then
        fillString = " "
    end
    if maxLength ~= maxLength then
        maxLength = 0
    end
    if maxLength == -math.huge or maxLength == math.huge then
        error("Invalid string length", 0)
    end
    if #self >= maxLength or #fillString == 0 then
        return self
    end
    maxLength = maxLength - #self
    if maxLength > #fillString then
        fillString = fillString .. string.rep(
            fillString,
            math.floor(maxLength / #fillString)
        )
    end
    return string.sub(
        fillString,
        1,
        math.floor(maxLength)
    ) .. self
end

local __TS__StringReplace
do
    local sub = string.sub
    function __TS__StringReplace(source, searchValue, replaceValue)
        local startPos, endPos = string.find(source, searchValue, nil, true)
        if not startPos then
            return source
        end
        local before = sub(source, 1, startPos - 1)
        local replacement = type(replaceValue) == "string" and replaceValue or replaceValue(nil, searchValue, startPos - 1, source)
        local after = sub(source, endPos + 1)
        return (before .. replacement) .. after
    end
end

local __TS__StringSplit
do
    local sub = string.sub
    local find = string.find
    function __TS__StringSplit(source, separator, limit)
        if limit == nil then
            limit = 4294967295
        end
        if limit == 0 then
            return {}
        end
        local result = {}
        local resultIndex = 1
        if separator == nil or separator == "" then
            for i = 1, #source do
                result[resultIndex] = sub(source, i, i)
                resultIndex = resultIndex + 1
            end
        else
            local currentPos = 1
            while resultIndex <= limit do
                local startPos, endPos = find(source, separator, currentPos, true)
                if not startPos then
                    break
                end
                result[resultIndex] = sub(source, currentPos, startPos - 1)
                resultIndex = resultIndex + 1
                currentPos = endPos + 1
            end
            if resultIndex <= limit then
                result[resultIndex] = sub(source, currentPos)
            end
        end
        return result
    end
end

local __TS__StringReplaceAll
do
    local sub = string.sub
    local find = string.find
    function __TS__StringReplaceAll(source, searchValue, replaceValue)
        if type(replaceValue) == "string" then
            local concat = table.concat(
                __TS__StringSplit(source, searchValue),
                replaceValue
            )
            if #searchValue == 0 then
                return (replaceValue .. concat) .. replaceValue
            end
            return concat
        end
        local parts = {}
        local partsIndex = 1
        if #searchValue == 0 then
            parts[1] = replaceValue(nil, "", 0, source)
            partsIndex = 2
            for i = 1, #source do
                parts[partsIndex] = sub(source, i, i)
                parts[partsIndex + 1] = replaceValue(nil, "", i, source)
                partsIndex = partsIndex + 2
            end
        else
            local currentPos = 1
            while true do
                local startPos, endPos = find(source, searchValue, currentPos, true)
                if not startPos then
                    break
                end
                parts[partsIndex] = sub(source, currentPos, startPos - 1)
                parts[partsIndex + 1] = replaceValue(nil, searchValue, startPos - 1, source)
                partsIndex = partsIndex + 2
                currentPos = endPos + 1
            end
            parts[partsIndex] = sub(source, currentPos)
        end
        return table.concat(parts)
    end
end

local function __TS__StringSlice(self, start, ____end)
    if start == nil or start ~= start then
        start = 0
    end
    if ____end ~= ____end then
        ____end = 0
    end
    if start >= 0 then
        start = start + 1
    end
    if ____end ~= nil and ____end < 0 then
        ____end = ____end - 1
    end
    return string.sub(self, start, ____end)
end

local function __TS__StringStartsWith(self, searchString, position)
    if position == nil or position < 0 then
        position = 0
    end
    return string.sub(self, position + 1, #searchString + position) == searchString
end

local function __TS__StringSubstr(self, from, length)
    if from ~= from then
        from = 0
    end
    if length ~= nil then
        if length ~= length or length <= 0 then
            return ""
        end
        length = length + from
    end
    if from >= 0 then
        from = from + 1
    end
    return string.sub(self, from, length)
end

local function __TS__StringTrim(self)
    local result = string.gsub(self, "^[%s ﻿]*(.-)[%s ﻿]*$", "%1")
    return result
end

local function __TS__StringTrimEnd(self)
    local result = string.gsub(self, "[%s ﻿]*$", "")
    return result
end

local function __TS__StringTrimStart(self)
    local result = string.gsub(self, "^[%s ﻿]*", "")
    return result
end

local __TS__SymbolRegistryFor, __TS__SymbolRegistryKeyFor
do
    local symbolRegistry = {}
    function __TS__SymbolRegistryFor(key)
        if not symbolRegistry[key] then
            symbolRegistry[key] = __TS__Symbol(key)
        end
        return symbolRegistry[key]
    end
    function __TS__SymbolRegistryKeyFor(sym)
        for key in pairs(symbolRegistry) do
            if symbolRegistry[key] == sym then
                return key
            end
        end
        return nil
    end
end

local function __TS__TypeOf(value)
    local luaType = type(value)
    if luaType == "table" then
        return "object"
    elseif luaType == "nil" then
        return "undefined"
    else
        return luaType
    end
end

local function __TS__Using(self, cb, ...)
    local args = {...}
    local thrownError
    local ok, result = xpcall(
        function() return cb(
            nil,
            __TS__Unpack(args)
        ) end,
        function(err)
            thrownError = err
            return thrownError
        end
    )
    local argArray = {__TS__Unpack(args)}
    do
        local i = #argArray - 1
        while i >= 0 do
            local ____self_0 = argArray[i + 1]
            ____self_0[Symbol.dispose](____self_0)
            i = i - 1
        end
    end
    if not ok then
        error(thrownError, 0)
    end
    return result
end

local function __TS__UsingAsync(self, cb, ...)
    local args = {...}
    return __TS__AsyncAwaiter(function(____awaiter_resolve)
        local thrownError
        local ok, result = xpcall(
            function() return cb(
                nil,
                __TS__Unpack(args)
            ) end,
            function(err)
                thrownError = err
                return thrownError
            end
        )
        local argArray = {__TS__Unpack(args)}
        do
            local i = #argArray - 1
            while i >= 0 do
                if argArray[i + 1][Symbol.dispose] ~= nil then
                    local ____self_0 = argArray[i + 1]
                    ____self_0[Symbol.dispose](____self_0)
                end
                if argArray[i + 1][Symbol.asyncDispose] ~= nil then
                    local ____self_1 = argArray[i + 1]
                    __TS__Await(____self_1[Symbol.asyncDispose](____self_1))
                end
                i = i - 1
            end
        end
        if not ok then
            error(thrownError, 0)
        end
        return ____awaiter_resolve(nil, result)
    end)
end

return {
  __TS__ArrayAt = __TS__ArrayAt,
  __TS__ArrayConcat = __TS__ArrayConcat,
  __TS__ArrayEntries = __TS__ArrayEntries,
  __TS__ArrayEvery = __TS__ArrayEvery,
  __TS__ArrayFill = __TS__ArrayFill,
  __TS__ArrayFilter = __TS__ArrayFilter,
  __TS__ArrayForEach = __TS__ArrayForEach,
  __TS__ArrayFind = __TS__ArrayFind,
  __TS__ArrayFindIndex = __TS__ArrayFindIndex,
  __TS__ArrayFrom = __TS__ArrayFrom,
  __TS__ArrayIncludes = __TS__ArrayIncludes,
  __TS__ArrayIndexOf = __TS__ArrayIndexOf,
  __TS__ArrayIsArray = __TS__ArrayIsArray,
  __TS__ArrayJoin = __TS__ArrayJoin,
  __TS__ArrayMap = __TS__ArrayMap,
  __TS__ArrayPush = __TS__ArrayPush,
  __TS__ArrayPushArray = __TS__ArrayPushArray,
  __TS__ArrayReduce = __TS__ArrayReduce,
  __TS__ArrayReduceRight = __TS__ArrayReduceRight,
  __TS__ArrayReverse = __TS__ArrayReverse,
  __TS__ArrayUnshift = __TS__ArrayUnshift,
  __TS__ArraySort = __TS__ArraySort,
  __TS__ArraySlice = __TS__ArraySlice,
  __TS__ArraySome = __TS__ArraySome,
  __TS__ArraySplice = __TS__ArraySplice,
  __TS__ArrayToObject = __TS__ArrayToObject,
  __TS__ArrayFlat = __TS__ArrayFlat,
  __TS__ArrayFlatMap = __TS__ArrayFlatMap,
  __TS__ArraySetLength = __TS__ArraySetLength,
  __TS__ArrayToReversed = __TS__ArrayToReversed,
  __TS__ArrayToSorted = __TS__ArrayToSorted,
  __TS__ArrayToSpliced = __TS__ArrayToSpliced,
  __TS__ArrayWith = __TS__ArrayWith,
  __TS__AsyncAwaiter = __TS__AsyncAwaiter,
  __TS__Await = __TS__Await,
  __TS__Class = __TS__Class,
  __TS__ClassExtends = __TS__ClassExtends,
  __TS__CloneDescriptor = __TS__CloneDescriptor,
  __TS__CountVarargs = __TS__CountVarargs,
  __TS__Decorate = __TS__Decorate,
  __TS__DecorateLegacy = __TS__DecorateLegacy,
  __TS__DecorateParam = __TS__DecorateParam,
  __TS__Delete = __TS__Delete,
  __TS__DelegatedYield = __TS__DelegatedYield,
  __TS__DescriptorGet = __TS__DescriptorGet,
  __TS__DescriptorSet = __TS__DescriptorSet,
  Error = Error,
  RangeError = RangeError,
  ReferenceError = ReferenceError,
  SyntaxError = SyntaxError,
  TypeError = TypeError,
  URIError = URIError,
  __TS__FunctionBind = __TS__FunctionBind,
  __TS__Generator = __TS__Generator,
  __TS__InstanceOf = __TS__InstanceOf,
  __TS__InstanceOfObject = __TS__InstanceOfObject,
  __TS__Iterator = __TS__Iterator,
  __TS__LuaIteratorSpread = __TS__LuaIteratorSpread,
  Map = Map,
  __TS__MapGroupBy = __TS__MapGroupBy,
  __TS__Match = __TS__Match,
  __TS__MathAtan2 = __TS__MathAtan2,
  __TS__MathModf = __TS__MathModf,
  __TS__MathSign = __TS__MathSign,
  __TS__MathTrunc = __TS__MathTrunc,
  __TS__New = __TS__New,
  __TS__Number = __TS__Number,
  __TS__NumberIsFinite = __TS__NumberIsFinite,
  __TS__NumberIsInteger = __TS__NumberIsInteger,
  __TS__NumberIsNaN = __TS__NumberIsNaN,
  __TS__ParseInt = __TS__ParseInt,
  __TS__ParseFloat = __TS__ParseFloat,
  __TS__NumberToString = __TS__NumberToString,
  __TS__NumberToFixed = __TS__NumberToFixed,
  __TS__ObjectAssign = __TS__ObjectAssign,
  __TS__ObjectDefineProperty = __TS__ObjectDefineProperty,
  __TS__ObjectEntries = __TS__ObjectEntries,
  __TS__ObjectFromEntries = __TS__ObjectFromEntries,
  __TS__ObjectGetOwnPropertyDescriptor = __TS__ObjectGetOwnPropertyDescriptor,
  __TS__ObjectGetOwnPropertyDescriptors = __TS__ObjectGetOwnPropertyDescriptors,
  __TS__ObjectGroupBy = __TS__ObjectGroupBy,
  __TS__ObjectKeys = __TS__ObjectKeys,
  __TS__ObjectRest = __TS__ObjectRest,
  __TS__ObjectValues = __TS__ObjectValues,
  __TS__ParseFloat = __TS__ParseFloat,
  __TS__ParseInt = __TS__ParseInt,
  __TS__Promise = __TS__Promise,
  __TS__PromiseAll = __TS__PromiseAll,
  __TS__PromiseAllSettled = __TS__PromiseAllSettled,
  __TS__PromiseAny = __TS__PromiseAny,
  __TS__PromiseRace = __TS__PromiseRace,
  Set = Set,
  __TS__SetDescriptor = __TS__SetDescriptor,
  __TS__SparseArrayNew = __TS__SparseArrayNew,
  __TS__SparseArrayPush = __TS__SparseArrayPush,
  __TS__SparseArraySpread = __TS__SparseArraySpread,
  WeakMap = WeakMap,
  WeakSet = WeakSet,
  __TS__SourceMapTraceBack = __TS__SourceMapTraceBack,
  __TS__Spread = __TS__Spread,
  __TS__StringAccess = __TS__StringAccess,
  __TS__StringCharAt = __TS__StringCharAt,
  __TS__StringCharCodeAt = __TS__StringCharCodeAt,
  __TS__StringEndsWith = __TS__StringEndsWith,
  __TS__StringIncludes = __TS__StringIncludes,
  __TS__StringPadEnd = __TS__StringPadEnd,
  __TS__StringPadStart = __TS__StringPadStart,
  __TS__StringReplace = __TS__StringReplace,
  __TS__StringReplaceAll = __TS__StringReplaceAll,
  __TS__StringSlice = __TS__StringSlice,
  __TS__StringSplit = __TS__StringSplit,
  __TS__StringStartsWith = __TS__StringStartsWith,
  __TS__StringSubstr = __TS__StringSubstr,
  __TS__StringSubstring = __TS__StringSubstring,
  __TS__StringTrim = __TS__StringTrim,
  __TS__StringTrimEnd = __TS__StringTrimEnd,
  __TS__StringTrimStart = __TS__StringTrimStart,
  __TS__Symbol = __TS__Symbol,
  Symbol = Symbol,
  __TS__SymbolRegistryFor = __TS__SymbolRegistryFor,
  __TS__SymbolRegistryKeyFor = __TS__SymbolRegistryKeyFor,
  __TS__TypeOf = __TS__TypeOf,
  __TS__Unpack = __TS__Unpack,
  __TS__Using = __TS__Using,
  __TS__UsingAsync = __TS__UsingAsync
}
 end,
["lua.helpers.module.useModule"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
function ____exports.useExternalModule(importTarget)
    do
        local function ____catch()
            console.error("Failed to import module " .. importTarget)
            return true, nil
        end
        local ____try, ____hasReturned, ____returnValue = pcall(function()
            return true, require(importTarget)
        end)
        if not ____try then
            ____hasReturned, ____returnValue = ____catch()
        end
        if ____hasReturned then
            return ____returnValue
        end
    end
end
return ____exports
 end,
["lua.plugins.nui"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
____exports.useNUI = function()
    return {
        Popup = useExternalModule("nui.popup"),
        Layout = useExternalModule("nui.layout"),
        Input = useExternalModule("nui.input"),
        Menu = useExternalModule("nui.menu"),
        Table = useExternalModule("nui.table"),
        Tree = useExternalModule("nui.tree"),
        Text = useExternalModule("nui.text"),
        Line = useExternalModule("nui.line"),
        Split = useExternalModule("nui.split"),
        event = useExternalModule("nui.utils.autocmd")
    }
end
local plugin = {[1] = "MunifTanjim/nui.nvim"}
____exports.default = plugin
return ____exports
 end,
["lua.custom.custom-open.index"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__StringReplaceAll = ____lualib.__TS__StringReplaceAll
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____nui = require("lua.plugins.nui")
local useNUI = ____nui.useNUI
local VIM_OPEN = vim.ui.open
local function open(target)
    local targets = __TS__ArrayFilter(
        {{pattern = ".*", name = "Firefox", command = "firefox %OPEN_TARGET%"}},
        function(____, pmatch)
            local result = vim.regex(pmatch.pattern):match_str(target)
            return result
        end
    )
    if #targets < 1 then
        return VIM_OPEN(target)
    end
    local NUI = useNUI()
    local menu = NUI.Menu(
        {position = "50%", size = {width = 33, height = 5}, border = {style = "single", text = {top = "Select Handler Program"}}},
        {
            lines = __TS__ArrayMap(
                targets,
                function(____, target) return NUI.Menu.item(target.name, {target = target}) end
            ),
            on_submit = function(_item)
                local item = _item
                local command = __TS__StringReplaceAll(item.target.command, "%OPEN_TARGET%", target)
                os.execute(command)
            end
        }
    )
    menu:mount()
    return nil
end
function ____exports.initCustomOpen()
    vim.ui.open = open
end
return ____exports
 end,
["lua.helpers.env-parser.index"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__StringStartsWith = ____lualib.__TS__StringStartsWith
local __TS__StringTrim = ____lualib.__TS__StringTrim
local __TS__StringSplit = ____lualib.__TS__StringSplit
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__ArraySlice = ____lualib.__TS__ArraySlice
local __TS__ArrayFind = ____lualib.__TS__ArrayFind
local __TS__StringReplaceAll = ____lualib.__TS__StringReplaceAll
local __TS__StringSlice = ____lualib.__TS__StringSlice
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
function ____exports.parseEnvFileContent(content)
    local result = {}
    local lines = __TS__ArrayFilter(
        __TS__ArrayFilter(
            __TS__ArrayMap(
                __TS__StringSplit(content, "\n"),
                function(____, x) return __TS__StringTrim(x) end
            ),
            function(____, x) return #x > 0 end
        ),
        function(____, x) return not __TS__StringStartsWith(x, "#") end
    )
    for ____, line in ipairs(lines) do
        local ____TS__StringSplit_result_0 = __TS__StringSplit(line, "=")
        local key = ____TS__StringSplit_result_0[1]
        local valuePossibleSplit = __TS__ArraySlice(____TS__StringSplit_result_0, 1)
        local valueWithPossibleComment = table.concat(valuePossibleSplit, "=")
        local value, comment = unpack(__TS__ArrayMap(
            __TS__StringSplit(valueWithPossibleComment, "#"),
            function(____, x) return __TS__StringTrim(x) end
        ))
        local STRING_DELIMS = {"\"", "'"}
        local delimiter = __TS__ArrayFind(
            STRING_DELIMS,
            function(____, x) return __TS__StringStartsWith(value, x) end
        )
        local finalValue = value
        if delimiter ~= nil then
            finalValue = __TS__StringReplaceAll(finalValue, "\\" .. delimiter, delimiter)
            finalValue = __TS__StringSlice(finalValue, 1, #finalValue - 1)
            finalValue = __TS__StringReplaceAll(finalValue, "\\n", "\n")
        end
        result[key] = finalValue
    end
    return result
end
return ____exports
 end,
["lua.helpers.user_command.argparser"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__StringStartsWith = ____lualib.__TS__StringStartsWith
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__New = ____lualib.__TS__New
local __TS__StringAccess = ____lualib.__TS__StringAccess
local __TS__StringEndsWith = ____lualib.__TS__StringEndsWith
local __TS__StringSlice = ____lualib.__TS__StringSlice
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
function ____exports.parseArgs(args)
    local result = {}
    local primedKey = nil
    do
        local i = 0
        while i < #args do
            local segment = args[i + 1]
            if __TS__StringStartsWith(segment, "--") then
                if primedKey ~= nil then
                    result[primedKey] = true
                end
                primedKey = string.sub(segment, 3)
            else
                if primedKey == nil then
                    error(
                        __TS__New(Error, "Expected a key, got a value"),
                        0
                    )
                elseif __TS__StringStartsWith(segment, "\"") or __TS__StringStartsWith(segment, "'") then
                    local delim = __TS__StringAccess(segment, 0)
                    local valueResult = string.sub(segment, 2)
                    local ____end = i
                    while ____end < #args and not __TS__StringEndsWith(args[____end + 1], delim) do
                        ____end = ____end + 1
                        valueResult = valueResult .. " " .. args[____end + 1]
                    end
                    if ____end >= #args or not __TS__StringEndsWith(args[____end + 1], delim) then
                        error(
                            __TS__New(Error, "Unterminated string: " .. args[____end + 1]),
                            0
                        )
                    end
                    valueResult = __TS__StringSlice(valueResult, 0, #valueResult - 1)
                    result[primedKey] = valueResult
                    i = ____end
                else
                    result[primedKey] = segment
                end
                primedKey = nil
            end
            i = i + 1
        end
    end
    if primedKey ~= nil then
        result[primedKey] = true
    end
    return result
end
return ____exports
 end,
["lua.shims.fs.index"] = function(...) 
local ____lualib = require("lualib_bundle")
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__New = ____lualib.__TS__New
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local function readFileSync(target)
    local file = io.open(target, "r")
    if file == nil then
        error(
            __TS__New(Error, "Failed to open file for read"),
            0
        )
    end
    local content = file:read("*a")
    file:close()
    if content == nil then
        error(
            __TS__New(Error, "Failed to read file"),
            0
        )
    end
    return content
end
local function writeFileSync(path, content)
    local file = io.open(path, "w")
    if file == nil then
        error(
            __TS__New(Error, "Failed to open file for writing"),
            0
        )
    end
    file:write(content)
    file:close()
end
local function readdirSync(path)
    local files = {}
    local handle = vim.uv.fs_scandir(path)
    if handle == nil then
        error(
            __TS__New(Error, "Cannot open directory " .. path),
            0
        )
    end
    while true do
        local name, ____type = vim.uv.fs_scandir_next(handle)
        if name == nil then
            break
        end
        files[#files + 1] = {path = name, type = ____type}
    end
    return files
end
local function existsSync(target)
    local file = io.open(target, "r")
    if file ~= nil then
        file:close()
        return true
    else
        return false
    end
end
____exports.fs = {readFileSync = readFileSync, existsSync = existsSync, writeFileSync = writeFileSync, readdirSync = readdirSync}
return ____exports
 end,
["lua.custom.env-load.index"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__StringEndsWith = ____lualib.__TS__StringEndsWith
local __TS__StringReplace = ____lualib.__TS__StringReplace
local __TS__ObjectKeys = ____lualib.__TS__ObjectKeys
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____env_2Dparser = require("lua.helpers.env-parser.index")
local parseEnvFileContent = ____env_2Dparser.parseEnvFileContent
local ____argparser = require("lua.helpers.user_command.argparser")
local parseArgs = ____argparser.parseArgs
local ____fs = require("lua.shims.fs.index")
local fs = ____fs.fs
local function loadEnvFromFile(targetFile, overwrite)
    local fileContent = fs.readFileSync(targetFile)
    local variables = parseEnvFileContent(fileContent)
    for key in pairs(variables) do
        do
            if vim.env[key] ~= nil then
                if not overwrite then
                    vim.notify(("Skipping environment variable '" .. key) .. "' because it's already set, and '--overwrite' was not specified", vim.log.levels.WARN)
                    goto __continue3
                end
            end
            vim.env[key] = variables[key]
        end
        ::__continue3::
    end
end
local _locatedEnvFiles = nil
vim.api.nvim_create_autocmd(
    "DirChanged",
    {callback = function()
        _locatedEnvFiles = nil
    end}
)
local function locateEnvFiles()
    if _locatedEnvFiles ~= nil then
        return _locatedEnvFiles
    end
    local cwd = vim.fn.getcwd()
    local envFiles = {}
    local isDebugCrawlEnabled = vim.g.debug_env_load
    local crawl
    crawl = function(path)
        local entries = fs.readdirSync(path)
        for ____, entry in ipairs(entries) do
            do
                if entry.type == "file" then
                    if __TS__StringEndsWith(entry.path, ".env") then
                        envFiles[#envFiles + 1] = (path .. "/") .. entry.path
                    end
                elseif entry.type == "directory" then
                    if entry.path == ".." then
                        goto __continue11
                    end
                    if entry.path == "." then
                        goto __continue11
                    end
                    do
                        local function ____catch()
                            if isDebugCrawlEnabled then
                                vim.notify(((("Failed to crawl directory '" .. path) .. "/") .. entry.path) .. "'")
                            end
                        end
                        local ____try = pcall(function()
                            crawl((path .. "/") .. entry.path)
                        end)
                        if not ____try then
                            ____catch()
                        end
                    end
                end
            end
            ::__continue11::
        end
    end
    crawl(cwd)
    _locatedEnvFiles = envFiles
    return envFiles
end
local function showEnvSourceDialog()
    local files = locateEnvFiles()
    vim.ui.select(
        files,
        {
            prompt = "Select a file to load",
            format_item = function(item)
                return __TS__StringReplace(
                    item,
                    vim.fn.getcwd() .. "/",
                    ""
                )
            end
        },
        function(choice)
            if choice == nil then
                return
            end
            vim.ui.select(
                {false, true},
                {
                    prompt = __TS__StringReplace(
                        choice,
                        vim.fn.getcwd() .. "/",
                        ""
                    ) .. ": Override Duplicates?",
                    format_item = function(item)
                        return item and "Yes" or "No"
                    end
                },
                function(override)
                    if override == nil then
                        return
                    end
                    loadEnvFromFile(choice, override)
                end
            )
        end
    )
end
function ____exports.initCustomEnvLoader()
    vim.api.nvim_create_user_command(
        "Env",
        function(_args)
            local args = parseArgs(_args.fargs)
            if #__TS__ObjectKeys(args) < 1 then
                vim.notify("Use --from-file, --scan, or --pick")
                return
            end
            local resolved = false
            if args["from-file"] ~= nil then
                resolved = true
                loadEnvFromFile(args["from-file"], not not args.overwrite)
            end
            if args.scan ~= nil then
                resolved = true
                local files = locateEnvFiles()
                for ____, file in ipairs(files) do
                    vim.notify(file)
                end
            end
            if args.pick ~= nil then
                resolved = true
                showEnvSourceDialog()
            end
            if not resolved then
                vim.notify(
                    "Cannot handle keys " .. table.concat(
                        __TS__ObjectKeys(args),
                        ","
                    ),
                    vim.log.levels.ERROR
                )
            end
        end,
        {nargs = "*"}
    )
end
return ____exports
 end,
["lua.custom.env-manager.index"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__StringSubstring = ____lualib.__TS__StringSubstring
local __TS__ArraySort = ____lualib.__TS__ArraySort
local __TS__ArrayFindIndex = ____lualib.__TS__ArrayFindIndex
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__New = ____lualib.__TS__New
local __TS__ArraySplice = ____lualib.__TS__ArraySplice
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____nui = require("lua.plugins.nui")
local useNUI = ____nui.useNUI
function ____exports.getEnvironment()
    return vim.api.nvim_call_function("environ", {})
end
local function createEnvironmentTableView()
    local MAX_LEN = 75
    local NUI = useNUI()
    local split = NUI.Split({position = "bottom", size = 25})
    local columns = {
        {
            align = "center",
            header = "Key",
            accessor_key = "key",
            cell = function(cell)
                return NUI.Line({NUI.Text(
                    tostring(cell.get_value()),
                    "DiagnosticInfo"
                )})
            end
        },
        {
            align = "center",
            header = "Value",
            accessor_key = "value",
            accessor_fn = function(row)
                local val = row.value
                if #val > MAX_LEN then
                    return __TS__StringSubstring(val, 0, MAX_LEN - 3) .. "..."
                end
                return val
            end,
            cell = function(cell)
                return NUI.Line({NUI.Text(
                    tostring(cell.get_value()),
                    "DiagnosticHint"
                )})
            end
        }
    }
    local data = (function()
        local result = {}
        local keys = (function()
            local result = {}
            local env = ____exports.getEnvironment()
            for key in pairs(env) do
                result[#result + 1] = key
            end
            __TS__ArraySort(result)
            return result
        end)()
        for ____, key in ipairs(keys) do
            do
                local value = vim.env[key]
                if value == nil then
                    goto __continue12
                end
                result[#result + 1] = {key = key, value = value}
            end
            ::__continue12::
        end
        return result
    end)()
    local ____table = NUI.Table({bufnr = split.bufnr, columns = columns, data = data})
    ____table:render()
    split:mount()
    local function destroy()
        split:unmount()
    end
    split:map(
        "n",
        "q",
        function()
            destroy()
        end
    )
    local function getCurrentContext()
        local cell = ____table:get_cell()
        if cell ~= nil then
            if cell.column.accessor_key then
                local targetKey = cell.row.original.key
                local dataEntryIndex = __TS__ArrayFindIndex(
                    data,
                    function(____, x) return x.key == targetKey end
                )
                local dataEntry
                if dataEntryIndex ~= -1 then
                    dataEntry = data[dataEntryIndex + 1]
                else
                    error(
                        __TS__New(Error, "Context attempted to get an environment record which does not exist"),
                        0
                    )
                end
                return {targetKey = targetKey, cell = cell, dataEntry = dataEntry}
            else
                return nil
            end
        else
            return nil
        end
    end
    split:map(
        "n",
        "dd",
        function()
            local cell = ____table:get_cell()
            if cell ~= nil then
                if cell.column.accessor_key then
                    local targetKey = cell.row.original[cell.column.accessor_key]
                    vim.env[targetKey] = nil
                    local index = __TS__ArrayFindIndex(
                        data,
                        function(____, x) return x.key == targetKey end
                    )
                    __TS__ArraySplice(data, index, 1)
                    ____table:render()
                    vim.notify(("Deleted environment variable '" .. targetKey) .. "'", vim.log.levels.INFO)
                end
            end
        end
    )
    split:map(
        "n",
        "yy",
        function()
            local context = getCurrentContext()
            if context ~= nil then
                local cellValue = tostring(context.cell.get_value())
                vim.fn.setreg("x", cellValue)
            end
        end
    )
    split:map(
        "n",
        "o",
        function()
            local key = vim.fn.input("Key: ")
            if #key == 0 then
                return
            end
            local value = vim.fn.input("Value: ")
            if #value == 0 then
                return
            end
            if __TS__ArrayFindIndex(
                data,
                function(____, x) return x.key == key end
            ) ~= -1 then
                vim.notify(("Environment variable '" .. key) .. "' already exists", vim.log.levels.ERROR)
                return
            end
            vim.env[key] = value
            data[#data + 1] = {key = key, value = value}
            ____table:render()
            vim.notify(("Created environment variable '" .. key) .. "'", vim.log.levels.INFO)
        end
    )
    split:map(
        "n",
        "r",
        function()
            local context = getCurrentContext()
            if context ~= nil then
                local oldKey = context.targetKey
                local newKey = vim.fn.input(("Rename environment variable '" .. oldKey) .. "' to: ", oldKey)
                if oldKey == newKey then
                    return
                end
                if __TS__ArrayFindIndex(
                    data,
                    function(____, x) return x.key == newKey end
                ) ~= -1 then
                    vim.notify("Destination environment variable already exists", vim.log.levels.ERROR)
                    return
                end
                context.dataEntry.key = newKey
                vim.env[newKey] = vim.env[oldKey]
                vim.env[oldKey] = nil
                ____table:render()
                vim.notify(((("Moved environment variable '" .. oldKey) .. "' to '") .. newKey) .. "'", vim.log.levels.INFO)
            end
        end
    )
    split:map(
        "n",
        "i",
        function()
            local context = getCurrentContext()
            if context ~= nil then
                local input = NUI.Input(
                    {position = "50%", size = {width = MAX_LEN}, border = {style = "single", text = {top = context.targetKey, top_align = "center"}}, win_options = {winhighlight = "Normal:Normal"}},
                    {
                        prompt = "",
                        default_value = vim.env[context.targetKey],
                        on_submit = function(value)
                            vim.env[context.targetKey] = value
                            context.dataEntry.value = value
                            ____table:render()
                        end
                    }
                )
                input:mount()
                input:map(
                    "n",
                    "q",
                    function()
                        input:unmount()
                    end
                )
            end
        end
    )
end
function ____exports.initCustomEnvManager()
    vim.api.nvim_create_user_command(
        "EnvEdit",
        function()
            createEnvironmentTableView()
        end,
        {nargs = 0}
    )
end
return ____exports
 end,
["lua.custom.getpid.index"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
function ____exports.initCustomGetPIDCommand()
    vim.api.nvim_create_user_command(
        "GetPID",
        function()
            vim.notify("PID: " .. tostring(vim.fn.getpid()))
        end,
        {nargs = 0}
    )
end
return ____exports
 end,
["lua.helpers.keymap.index"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
function ____exports.keyMappingExists(mode, bind)
    local result = vim.api.nvim_call_function("mapcheck", {bind, mode})
    if result ~= nil and #result > 0 then
        return true
    else
        return false
    end
end
function ____exports.applyKeyMapping(map)
    map.options = __TS__ObjectAssign({silent = true}, map.options)
    if map.action ~= nil then
        vim.keymap.set(map.mode, map.inputStroke, map.action, map.options)
    else
        vim.keymap.set(map.mode, map.inputStroke, map.outputStroke, map.options)
    end
end
return ____exports
 end,
["lua.custom.git.index"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____keymap = require("lua.helpers.keymap.index")
local applyKeyMapping = ____keymap.applyKeyMapping
function ____exports.initCustomGit()
    applyKeyMapping({
        mode = "n",
        inputStroke = "<c-c>",
        action = function()
            vim.ui.input(
                {prompt = "Commit Message: "},
                function(message)
                    if message == nil or #message < 1 then
                        return
                    else
                        vim.notify(vim.fn.system({"git", "add", "--all"}))
                        vim.notify(vim.fn.system({"git", "commit", "-m", message}))
                    end
                end
            )
        end,
        options = {desc = "Commit"}
    })
end
return ____exports
 end,
["lua.custom.jumplist.index"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
function ____exports.initCustomJumplist()
    vim.api.nvim_create_user_command(
        "JumpListClear",
        function()
            vim.cmd("tabdo windo clearjumps | tabnext")
        end,
        {}
    )
end
return ____exports
 end,
["lua.custom.profile.index"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local ____argparser = require("lua.helpers.user_command.argparser")
local parseArgs = ____argparser.parseArgs
function ____exports.setupCustomProfilerCommands()
    vim.api.nvim_create_user_command(
        "LuaJITProfiler",
        function(_args)
            local args = parseArgs(_args.fargs)
            local function getJIT()
                return useExternalModule("jit.p")
            end
            if args.operation == "start" then
                getJIT().start("32", "profile.txt")
            elseif args.operation == "stop" then
                getJIT().stop()
            end
        end,
        {nargs = "*"}
    )
end
return ____exports
 end,
["lua.custom.nixos.index"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____fs = require("lua.shims.fs.index")
local fs = ____fs.fs
function ____exports.isRunningUnderNixOS()
    return fs.existsSync("/etc/NIXOS")
end
return ____exports
 end,
["lua.theme"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local h, applySymbolUsageStyle, applyDapSymbols, applyDefaultFoldChars
function h(name)
    return vim.api.nvim_get_hl(0, {name = name})
end
function applySymbolUsageStyle()
    vim.api.nvim_set_hl(
        0,
        "SymbolUsageRounding",
        {
            fg = h("CursorLine").bg,
            italic = true
        }
    )
    vim.api.nvim_set_hl(
        0,
        "SymbolUsageContent",
        {
            bg = h("CursorLine").bg,
            fg = h("Comment").fg,
            italic = true
        }
    )
    vim.api.nvim_set_hl(
        0,
        "SymbolUsageRef",
        {
            fg = h("Function").fg,
            bg = h("CursorLine").bg,
            italic = true
        }
    )
    vim.api.nvim_set_hl(
        0,
        "SymbolUsageDef",
        {
            fg = h("Type").fg,
            bg = h("CursorLine").bg,
            italic = true
        }
    )
    vim.api.nvim_set_hl(
        0,
        "SymbolUsageImpl",
        {
            fg = h("@keyword").fg,
            bg = h("CursorLine").bg,
            italic = true
        }
    )
end
function applyDapSymbols()
    vim.api.nvim_set_hl(0, "DapBreakpoint", {ctermbg = 0, fg = "#993939", bg = "#31353f"})
    vim.api.nvim_set_hl(0, "DapLogPoint", {ctermbg = 0, fg = "#61afef", bg = "#31353f"})
    vim.api.nvim_set_hl(0, "DapStopped", {ctermbg = 0, fg = "#98c379", bg = "#31353f"})
    vim.fn.sign_define("DapBreakpoint", {text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint"})
    vim.fn.sign_define("DapBreakpointCondition", {text = "ﳁ", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint"})
    vim.fn.sign_define("DapBreakpointRejected", {text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint"})
    vim.fn.sign_define("DapLogPoint", {text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint"})
    vim.fn.sign_define("DapStopped", {text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped"})
end
function applyDefaultFoldChars()
    vim.o.fillchars = "eob: ,fold: ,foldopen:,foldsep: ,foldclose:"
end
local themeType = "dark"
local callbacks = {}
function ____exports.onThemeChange(callback)
    callbacks[#callbacks + 1] = callback
end
local function updateThemeType(____type)
    themeType = ____type
    for ____, callback in ipairs(callbacks) do
        callback(____type)
    end
end
function ____exports.globalThemeType()
    return themeType
end
local function VSCode()
    vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", {bg = "NONE", strikethrough = true, fg = "#808080"})
    applyDefaultFoldChars()
    applyDapSymbols()
    applySymbolUsageStyle()
    updateThemeType("dark")
end
local function TokyoNight()
    vim.cmd("colorscheme tokyonight-storm")
    updateThemeType("dark")
    applyDapSymbols()
    applyDefaultFoldChars()
    applySymbolUsageStyle()
end
local function Catppuccin()
    vim.cmd("colorscheme catppuccin")
    applyDefaultFoldChars()
    applyDapSymbols()
    applySymbolUsageStyle()
    updateThemeType("dark")
end
local function Kanagawa()
    vim.cmd("colorscheme kanagawa")
    updateThemeType("dark")
    applySymbolUsageStyle()
    applyDefaultFoldChars()
    applyDapSymbols()
end
local function Nord()
    vim.cmd("colorscheme nord")
    updateThemeType("dark")
    applySymbolUsageStyle()
    applyDefaultFoldChars()
    applyDapSymbols()
end
local function Poimandres()
    vim.cmd("colorscheme poimandres")
    updateThemeType("dark")
    applySymbolUsageStyle()
    applyDefaultFoldChars()
    applyDapSymbols()
end
local function Bluloco()
    vim.opt.termguicolors = true
    vim.cmd("colorscheme bluloco")
    updateThemeType("dark")
    applySymbolUsageStyle()
    applyDefaultFoldChars()
    applyDapSymbols()
end
local function Midnight()
    vim.cmd("colorscheme midnight")
    updateThemeType("dark")
    applySymbolUsageStyle()
    applyDefaultFoldChars()
    applyDapSymbols()
end
local function Default()
    updateThemeType("dark")
    applySymbolUsageStyle()
    applyDefaultFoldChars()
    applyDapSymbols()
end
____exports.THEME_APPLIERS = {
    VSCode = VSCode,
    TokyoNight = TokyoNight,
    Catppuccin = Catppuccin,
    Kanagawa = Kanagawa,
    Nord = Nord,
    Poimandres = Poimandres,
    Bluloco = Bluloco,
    Midnight = Midnight,
    Default = Default
}
return ____exports
 end,
["lua.helpers.persistent-data.index"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____fs = require("lua.shims.fs.index")
local fs = ____fs.fs
local persistValueInstances = {}
local dataPath = vim.fn.stdpath("data") .. "/winvim"
vim.fn.system({"mkdir", "-p", dataPath})
function ____exports.getWinvimLocalDataDirectory()
    return dataPath
end
function ____exports.usePersistentValue(key, defaultValue)
    do
        local target = persistValueInstances[key]
        if target ~= nil then
            return target
        end
    end
    local filePath = (dataPath .. "/") .. key
    local currentValue = defaultValue
    if fs.existsSync(filePath) then
        currentValue = vim.json.decode(fs.readFileSync(filePath))
    end
    local function get()
        return currentValue
    end
    local function set(newValue)
        currentValue = newValue
        fs.writeFileSync(
            filePath,
            vim.json.encode(newValue)
        )
        return currentValue
    end
    local result = {get, set}
    persistValueInstances[key] = result
    return result
end
return ____exports
 end,
["lua.helpers.configuration.index"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__ObjectKeys = ____lualib.__TS__ObjectKeys
local __TS__StringSplit = ____lualib.__TS__StringSplit
local __TS__ArrayReverse = ____lualib.__TS__ArrayReverse
local __TS__StringIncludes = ____lualib.__TS__StringIncludes
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__TypeOf = ____lualib.__TS__TypeOf
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__New = ____lualib.__TS__New
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local reloadConfiguration, saveConfiguration, configuration, getGlobalConfig, setGlobalConfig
local ____nixos = require("lua.custom.nixos.index")
local isRunningUnderNixOS = ____nixos.isRunningUnderNixOS
local ____persistent_2Ddata = require("lua.helpers.persistent-data.index")
local usePersistentValue = ____persistent_2Ddata.usePersistentValue
local ____argparser = require("lua.helpers.user_command.argparser")
local parseArgs = ____argparser.parseArgs
function reloadConfiguration()
    local config = getGlobalConfig()
    if #__TS__ObjectKeys(config) < 1 then
        configuration = ____exports.CONFIGURATION_DEFAULTS
        ____exports.saveGlobalConfiguration()
        configuration = getGlobalConfig()
    else
        configuration = config
    end
end
function saveConfiguration()
    setGlobalConfig(configuration)
end
function ____exports.getGlobalConfiguration()
    if configuration == nil then
        reloadConfiguration()
    end
    return configuration
end
function ____exports.saveGlobalConfiguration()
    saveConfiguration()
end
configuration = nil
getGlobalConfig, setGlobalConfig = unpack(usePersistentValue("configuration.json", {}))
____exports.CONFIGURATION_DEFAULTS = {
    theme = {key = "TokyoNight"},
    packages = {
        copilotLuaLine = {enabled = true},
        mason = {enabled = not isRunningUnderNixOS()},
        nvimTree = {enabled = true},
        floatTerm = {enabled = true},
        autoPairs = {enabled = true},
        lspConfig = {enabled = true},
        treeSitter = {enabled = true},
        lspLines = {enabled = false},
        cmp = {enabled = true},
        telescope = {enabled = true},
        lspUI = {enabled = false},
        rustaceanvim = {enabled = false},
        lspSignature = {enabled = true},
        indentBlankline = {enabled = true},
        treeDevIcons = {enabled = true},
        luaLine = {enabled = true},
        barBar = {enabled = true},
        comments = {enabled = true},
        marks = {enabled = true},
        trouble = {enabled = true},
        outline = {enabled = true},
        glance = {enabled = true},
        nvimDapUI = {enabled = true, config = {lldb = {port = 1828}}},
        diffView = {enabled = true},
        lazyGit = {enabled = true},
        noice = {enabled = false},
        nvimNotify = {enabled = true},
        copilot = {enabled = true},
        actionsPreview = {enabled = true},
        fireNvim = {enabled = true},
        ufo = {enabled = true},
        lspconfig = {enabled = true, config = {inlayHints = {enabled = true, displayMode = "always"}}},
        markdownPreview = {enabled = true},
        gitBrowse = {enabled = true},
        obsidian = {enabled = false, config = {workspaces = {{name = "notes", path = "~/Documents/obsidian/notes"}}}},
        undoTree = {enabled = true},
        octo = {enabled = true},
        leap = {enabled = false},
        cSharp = {enabled = true},
        telescopeUISelect = {enabled = true},
        masonNvimDap = {enabled = false},
        timeTracker = {enabled = false},
        wakaTime = {enabled = true},
        surround = {enabled = true},
        tsAutoTag = {enabled = true},
        ultimateAutoPair = {enabled = true},
        rainbowDelimiters = {enabled = false},
        markview = {enabled = true},
        symbolUsage = {enabled = true},
        neotest = {enabled = true},
        navic = {enabled = false},
        illuminate = {enabled = false},
        treesj = {enabled = true},
        iconPicker = {enabled = true},
        todoComments = {enabled = true},
        crates = {enabled = true, config = {bleedingEdge = false}},
        dbee = {enabled = true},
        lightbulb = {enabled = false},
        neogen = {enabled = true},
        tsContextCommentString = {enabled = true},
        nvimDapVirtualText = {enabled = true},
        overseer = {enabled = false},
        hlchunk = {enabled = false},
        rest = {enabled = true},
        flatten = {enabled = true},
        tinyInlineDiagnostic = {enabled = false},
        screenkey = {enabled = true},
        hex = {enabled = true},
        fidget = {enabled = true},
        treesitterContext = {enabled = false},
        gotoPreview = {enabled = true},
        dropBar = {enabled = true},
        presence = {enabled = true},
        timerly = {enabled = true}
    },
    targetEnvironments = {
        typescript = {enabled = true},
        deno = {enabled = true},
        ["c/c++"] = {enabled = true},
        markdown = {enabled = true},
        lua = {enabled = true},
        yaml = {enabled = true},
        rust = {enabled = true},
        bash = {enabled = true},
        python = {enabled = true},
        go = {enabled = true}
    },
    shell = {target = "tmux", isolationScope = "global"},
    integrations = {ollama = {enabled = true, config = {model = "codellama:code", ["num-predict"] = 5}}}
}
local watchers = {}
function ____exports.useConfigWatcher(key, watcher)
    watchers[#watchers + 1] = {key, watcher}
    local parts = __TS__ArrayReverse(__TS__StringSplit(key, "."))
    local function currentTarget()
        return parts[#parts]
    end
    local current = ____exports.getGlobalConfiguration()
    while #parts > 1 do
        current = current[currentTarget()]
        table.remove(parts)
    end
    watcher(current, key)
end
vim.api.nvim_create_user_command(
    "Configuration",
    function(_args)
        local args = parseArgs(_args.fargs)
        if args.mode == "delete" then
            local parts = __TS__ArrayReverse(__TS__StringSplit(args.key, "."))
            local function currentTarget()
                return parts[#parts]
            end
            local current = ____exports.getGlobalConfiguration()
            while #parts > 1 do
                local next = current[currentTarget()]
                if next == nil then
                    next = {}
                    current[currentTarget()] = next
                    current = next
                else
                    current = next
                end
                table.remove(parts)
            end
            current[currentTarget()] = nil
            for ____, watcher in ipairs(__TS__ArrayFilter(
                watchers,
                function(____, x) return __TS__StringIncludes(x[1], args.key) end
            )) do
                watcher[2](nil, args.key)
            end
            ____exports.saveGlobalConfiguration()
        elseif args.mode == "list" then
            if args.key == nil then
                args.key = ""
            end
            local parts = __TS__ArrayReverse(__TS__StringSplit(args.key, "."))
            if args.key == "" then
                parts = {}
            end
            local function currentTarget()
                return parts[#parts]
            end
            local current = ____exports.getGlobalConfiguration()
            while #parts > 0 do
                current = current[currentTarget()]
                table.remove(parts)
            end
            if type(current) == "nil" then
                console.error(("Config path '" .. args.key) .. "' is undefined")
                return
            elseif type(current) == "table" then
                for key in pairs(current) do
                    console.log(((((("'" .. key) .. "': <") .. tostring(current[key])) .. "> (") .. __TS__TypeOf(current[key])) .. ")")
                end
            else
                console.log(tostring(current))
            end
        elseif args.mode == "get" then
            local parts = __TS__ArrayReverse(__TS__StringSplit(args.key, "."))
            local function currentTarget()
                return parts[#parts]
            end
            local current = ____exports.getGlobalConfiguration()
            while #parts > 1 do
                current = current[currentTarget()]
                table.remove(parts)
            end
            console.log(tostring(current[parts[1]]))
        elseif args.mode == "set" then
            local parts = __TS__ArrayReverse(__TS__StringSplit(args.key, "."))
            local function currentTarget()
                return parts[#parts]
            end
            local current = ____exports.getGlobalConfiguration()
            while #parts > 1 do
                local next = current[currentTarget()]
                if next == nil then
                    next = {}
                    current[currentTarget()] = next
                    current = next
                else
                    current = next
                end
                table.remove(parts)
            end
            local currentType = args.type or __TS__TypeOf(current[currentTarget()])
            if currentType == "undefined" then
                console.error("Cannot infer desired type from existing value: does not exist. ")
                console.error("Supply --type 'string' | 'number' | 'boolean' argument")
                return
            end
            if currentType == "string" then
                current[currentTarget()] = args.value
            elseif currentType == "boolean" then
                current[currentTarget()] = args.value == "true"
            elseif currentType == "number" then
                current[currentTarget()] = tonumber(args.value)
            else
                error(
                    __TS__New(Error, ("Cannot convert target type to " .. currentType) .. ": unsupported"),
                    0
                )
            end
            for ____, watcher in ipairs(__TS__ArrayFilter(
                watchers,
                function(____, x) return __TS__StringIncludes(x[1], args.key) end
            )) do
                watcher[2](
                    current[currentTarget()],
                    args.key
                )
            end
            ____exports.saveGlobalConfiguration()
        else
            local target = args.mode
            if target == nil then
                console.warn("Argument 'mode' is required, either get or set")
            else
                console.error(("Mode '" .. tostring(target)) .. "' is unsupported")
            end
        end
    end,
    {nargs = "*"}
)
return ____exports
 end,
["lua.custom.tmux.index"] = function(...) 
local ____lualib = require("lualib_bundle")
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__New = ____lualib.__TS__New
local __TS__StringReplace = ____lualib.__TS__StringReplace
local __TS__StringIncludes = ____lualib.__TS__StringIncludes
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____configuration = require("lua.helpers.configuration.index")
local getGlobalConfiguration = ____configuration.getGlobalConfiguration
local ____nui = require("lua.plugins.nui")
local useNUI = ____nui.useNUI
local ____fs = require("lua.shims.fs.index")
local fs = ____fs.fs
local function setTmuxScope(isolationScope)
    local globalConfig = getGlobalConfiguration()
    if isolationScope == "global" then
        vim.o.shell = "tmux"
        globalConfig.shell.isolationScope = "global"
    elseif isolationScope == "neovim-shared" then
        vim.o.shell = "tmux -L neovim"
        globalConfig.shell.isolationScope = "neovim-shared"
    elseif isolationScope == "per-instance" then
        vim.o.shell = "tmux -L neovim-" .. tostring(vim.fn.getpid())
        globalConfig.shell.isolationScope = "isolated"
    else
        error(
            __TS__New(Error, "Invalid scope " .. isolationScope),
            0
        )
    end
end
local function changeTmuxScope()
    local NUI = useNUI()
    local menu = NUI.Menu(
        {position = "50%", size = {width = 33, height = 3}, border = {style = "single", text = {top = "Change TMUX scope"}}},
        {
            lines = {
                NUI.Menu.item("Global", {target = "global"}),
                NUI.Menu.item("Shared between neovim instances", {target = "neovim-shared"}),
                NUI.Menu.item("Isolated", {target = "per-instance"})
            },
            on_submit = function(_item)
                local item = _item
                setTmuxScope(item.target)
            end
        }
    )
    menu:mount()
end
local function pruneDeadTmuxSockets()
    local SOCKET_DIR = vim.env.TMUX_TMPDIR or "/tmp"
    local userID = vim.loop.getuid()
    local socketsDirectory = (SOCKET_DIR .. "/tmux-") .. tostring(userID)
    vim.fn.system({"bash", "-c", ("rm -f " .. socketsDirectory) .. "/*"})
    vim.fn.system({"pkill", "-USR1", "tmux"})
end
function ____exports.selectCustomTmuxScope()
    local ____opt_0 = getGlobalConfiguration().packages.floatTerm
    if ____opt_0 and ____opt_0.enabled then
        do
            pcall(function()
                vim.cmd("FloatermKill!")
            end)
        end
    end
    pruneDeadTmuxSockets()
    local SOCKET_DIR = vim.env.TMUX_TMPDIR or "/tmp"
    local userID = vim.loop.getuid()
    local socketsDirectory = (SOCKET_DIR .. "/tmux-") .. tostring(userID)
    local entries = fs.readdirSync(socketsDirectory)
    vim.ui.select(
        entries,
        {
            prompt = "Select a session",
            format_item = function(item)
                local label = __TS__StringReplace(item.path, socketsDirectory .. "/", "")
                if __TS__StringIncludes(
                    item.path,
                    tostring(vim.fn.getpid())
                ) then
                    return label .. " -- Instance Pair"
                else
                    return label
                end
            end
        },
        function(choice)
            if choice == nil then
                return
            end
            local id = __TS__StringReplace(choice.path, socketsDirectory .. "/", "")
            vim.g.terminal_emulator = "tmux -L " .. id
            local ____opt_2 = getGlobalConfiguration().packages.floatTerm
            if ____opt_2 and ____opt_2.enabled then
                do
                    pcall(function()
                        vim.cmd("FloatermKill!")
                        vim.g.floaterm_title = "tmux " .. id
                    end)
                end
            end
            console.log(vim.g.terminal_emulator)
        end
    )
end
function ____exports.isRunningInsideTmux()
    local ____opt_4 = os.getenv("TERM")
    if ____opt_4 and __TS__StringIncludes(
        os.getenv("TERM"),
        "tmux"
    ) then
        return true
    else
        return false
    end
end
function ____exports.initCustomTmux()
    local shellConfig = getGlobalConfiguration().shell
    if shellConfig.target == "tmux" then
        local term = os.getenv("TERM") or "__term_value_not_supplied"
        if not __TS__StringIncludes(term, "tmux") then
            vim.g.terminal_emulator = "tmux"
            local isolationScope = shellConfig.isolationScope
            if isolationScope == "global" then
                vim.o.shell = "tmux"
            elseif isolationScope == "neovim-shared" then
                vim.o.shell = "tmux -L neovim"
            elseif isolationScope == "isolated" then
                vim.o.shell = "tmux -L neovim-" .. tostring(vim.fn.getpid())
            else
                vim.notify(("Invalid option '" .. tostring(isolationScope)) .. "' for tmux isolation scope.")
                vim.o.shell = "tmux"
            end
        else
        end
    end
    vim.api.nvim_create_user_command("ChangeTmuxScope", changeTmuxScope, {})
    vim.api.nvim_create_user_command("SelectTmuxScope", ____exports.selectCustomTmuxScope, {})
    vim.api.nvim_create_user_command("PruneTmuxInstanceSockets", pruneDeadTmuxSockets, {})
end
return ____exports
 end,
["lua.custom.index"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____custom_2Dopen = require("lua.custom.custom-open.index")
local initCustomOpen = ____custom_2Dopen.initCustomOpen
local ____env_2Dload = require("lua.custom.env-load.index")
local initCustomEnvLoader = ____env_2Dload.initCustomEnvLoader
local ____env_2Dmanager = require("lua.custom.env-manager.index")
local initCustomEnvManager = ____env_2Dmanager.initCustomEnvManager
local ____getpid = require("lua.custom.getpid.index")
local initCustomGetPIDCommand = ____getpid.initCustomGetPIDCommand
local ____git = require("lua.custom.git.index")
local initCustomGit = ____git.initCustomGit
local ____jumplist = require("lua.custom.jumplist.index")
local initCustomJumplist = ____jumplist.initCustomJumplist
local ____profile = require("lua.custom.profile.index")
local setupCustomProfilerCommands = ____profile.setupCustomProfilerCommands
local ____tmux = require("lua.custom.tmux.index")
local initCustomTmux = ____tmux.initCustomTmux
function ____exports.setupCustomLogic()
    initCustomTmux()
    initCustomOpen()
    initCustomEnvLoader()
    initCustomJumplist()
    initCustomGit()
    setupCustomProfilerCommands()
    initCustomGetPIDCommand()
    initCustomEnvManager()
end
return ____exports
 end,
["lua.integrations.neovide"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
function ____exports.isNeovideSession()
    return vim.g.neovide ~= nil
end
function ____exports.getNeovideExtendedVimContext()
    return vim
end
return ____exports
 end,
["lua.shims.mainLoopCallbacks"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
function ____exports.setTimeout(callback, ms)
    local cancelFlag = false
    local function cancel()
        cancelFlag = true
    end
    local function wrapper()
        if not cancelFlag then
            callback()
        end
    end
    vim.defer_fn(wrapper, ms)
    return cancel
end
function ____exports.setImmediate(callback)
    return vim.schedule(callback)
end
function ____exports.setInterval(callback, interval)
    local cancelFlag = false
    local wrapper
    wrapper = function()
        if not cancelFlag then
            callback()
            ____exports.setTimeout(wrapper, interval)
        end
    end
    local function cancel()
        cancelFlag = true
    end
    ____exports.setTimeout(wrapper, interval)
    return cancel
end
function ____exports.clearTimeout(handle)
    handle()
end
function ____exports.clearInterval(handle)
    handle()
end
function ____exports.insertMainLoopCallbackShims()
    local global = _G
    global.setTimeout = ____exports.setTimeout
    global.clearTimeout = ____exports.clearTimeout
    global.setInterval = ____exports.setInterval
    global.clearInterval = ____exports.clearInterval
    global.setImmediate = ____exports.setImmediate
end
return ____exports
 end,
["lua.helpers.font.index"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__StringReplaceAll = ____lualib.__TS__StringReplaceAll
local __TS__Promise = ____lualib.__TS__Promise
local __TS__New = ____lualib.__TS__New
local __TS__AsyncAwaiter = ____lualib.__TS__AsyncAwaiter
local __TS__Await = ____lualib.__TS__Await
local __TS__ArrayIndexOf = ____lualib.__TS__ArrayIndexOf
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__ArraySlice = ____lualib.__TS__ArraySlice
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____neovide = require("lua.integrations.neovide")
local getNeovideExtendedVimContext = ____neovide.getNeovideExtendedVimContext
local isNeovideSession = ____neovide.isNeovideSession
local ____mainLoopCallbacks = require("lua.shims.mainLoopCallbacks")
local setTimeout = ____mainLoopCallbacks.setTimeout
function ____exports.setGUIFont(fontName, fontSize)
    if isNeovideSession() then
        fontName = __TS__StringReplaceAll(fontName, " ", "_")
        local opts = getNeovideExtendedVimContext()
        opts.o.guifont = (fontName .. ":h") .. tostring(fontSize)
    else
        vim.notify("Cannot update GUI font: feature is only available in a Neovide context", vim.log.levels.ERROR)
    end
end
function ____exports.getAvailableGUIFonts()
    return __TS__AsyncAwaiter(function(____awaiter_resolve)
        if isNeovideSession() then
            vim.cmd("set guifont=*")
            __TS__Await(__TS__New(
                __TS__Promise,
                function(____, resolve) return setTimeout(
                    function() return resolve(nil) end,
                    500
                ) end
            ))
            local buffer = vim.api.nvim_get_current_buf()
            local lines = vim.api.nvim_buf_get_lines(
                buffer,
                0,
                vim.api.nvim_buf_line_count(buffer),
                false
            )
            local targetIndex = __TS__ArrayIndexOf(lines, "Available Fonts on this System")
            if targetIndex == -1 then
                error(
                    __TS__New(Error, "Possible format change"),
                    0
                )
            end
            targetIndex = targetIndex + 2
            return ____awaiter_resolve(
                nil,
                __TS__ArraySlice(lines, targetIndex)
            )
        else
            error(
                __TS__New(Error, "Fetching the list of available GUI font options is only possible under Neovide"),
                0
            )
        end
    end)
end
return ____exports
 end,
["lua.helpers.vim-feature-unwrappers.diffopt"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
function ____exports.createDiffOptString(config)
    local result = ""
    local function addSection(section)
        if #result < 1 then
            result = section
        else
            result = result .. "," .. section
        end
    end
    if config.lineMatch then
        addSection("linematch:" .. tostring(config.lineMatch))
    end
    if config.internal then
        addSection("internal")
    end
    if config.filler then
        addSection("filler")
    end
    if config.closeoff then
        addSection("closeoff")
    end
    if config.indentHeuristic then
        addSection("indent-heuristic")
    end
    if config.foldColumn then
        addSection("foldcolumn:" .. tostring(config.foldColumn))
    end
    return result
end
return ____exports
 end,
["lua.integrations.hyprland"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__StringTrim = ____lualib.__TS__StringTrim
local __TS__StringSplit = ____lualib.__TS__StringSplit
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__StringIncludes = ____lualib.__TS__StringIncludes
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__Number = ____lualib.__TS__Number
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
function ____exports.isDesktopHyprland()
    return os.getenv("HYPRLAND_INSTANCE_SIGNATURE") ~= nil
end
local function getRefreshRates()
    local out = __TS__ArrayMap(
        __TS__StringSplit(
            vim.fn.system({"hyprctl", "monitors"}),
            "\n"
        ),
        function(____, x) return __TS__StringTrim(x) end
    )
    local targets = __TS__ArrayFilter(
        __TS__ArrayMap(
            __TS__ArrayFilter(
                out,
                function(____, x) return not __TS__StringIncludes(x, ":") end
            ),
            function(____, x) return __TS__StringTrim(x) end
        ),
        function(____, x) return #x > 0 end
    )
    local function extractRefreshRate(line)
        local resAndRefresh = unpack(__TS__StringSplit(line, " at "))
        local resolution, refreshRate = unpack(__TS__StringSplit(resAndRefresh, "@"))
        return __TS__Number(refreshRate)
    end
    return __TS__ArrayMap(
        targets,
        function(____, x) return extractRefreshRate(x) end
    )
end
____exports.Hyprland = {getRefreshRates = getRefreshRates}
return ____exports
 end,
["lua.helpers.network.getOpenPort"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__Number = ____lualib.__TS__Number
local __TS__StringSplit = ____lualib.__TS__StringSplit
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
function ____exports.getOpenPorts(args)
    local count = args and args.count or 1
    local start = args and args.start or 49152
    local ____end = args and args["end"] or 65535
    local cmdResult = vim.fn.system({
        "bash",
        "-c",
        (((("comm -23 <(seq " .. tostring(start)) .. " ") .. tostring(____end)) .. " | sort) <(ss -Htan | awk '{print $4}' | cut -d':' -f2 | sort -u) | shuf | head -n ") .. tostring(count)
    })
    local ports = __TS__ArrayFilter(
        __TS__ArrayMap(
            __TS__StringSplit(cmdResult, "\n"),
            function(____, x) return __TS__Number(x) end
        ),
        function(____, x) return x ~= 0 end
    )
    return ports
end
return ____exports
 end,
["lua.integrations.ollama"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____configuration = require("lua.helpers.configuration.index")
local getGlobalConfiguration = ____configuration.getGlobalConfiguration
local ____getOpenPort = require("lua.helpers.network.getOpenPort")
local getOpenPorts = ____getOpenPort.getOpenPorts
local ____mainLoopCallbacks = require("lua.shims.mainLoopCallbacks")
local setImmediate = ____mainLoopCallbacks.setImmediate
local ollamaCopilotExecutable = "ollama-copilot"
local ollamaExecutable = "ollama"
function ____exports.isOllamaIntegrationAllowed()
    local ____opt_0 = getGlobalConfiguration().integrations.ollama
    local ____temp_2 = ____opt_0 and ____opt_0.enabled
    if ____temp_2 == nil then
        ____temp_2 = false
    end
    if not ____temp_2 then
        return {success = false, reason = "Ollama integration is not enabled in configuration"}
    end
    if vim.fn.executable(ollamaCopilotExecutable) == 0 then
        return {success = false, reason = ("Could not find " .. ollamaCopilotExecutable) .. "."}
    end
    if vim.fn.executable(ollamaExecutable) == 0 then
        return {success = false, reason = ("Could not find " .. ollamaExecutable) .. "."}
    end
    do
        local output = vim.fn.system({"pidof", "ollama"})
        if output == "" then
            return {success = false, reason = "ollama is not running"}
        end
    end
    return {success = true}
end
local function getOllamaConfig()
    local ____opt_3 = getGlobalConfiguration().integrations.ollama
    local ____temp_5 = ____opt_3 and ____opt_3.config
    if ____temp_5 == nil then
        ____temp_5 = {}
    end
    local remoteConfig = ____temp_5
    return remoteConfig
end
function ____exports.ollamaIntegration()
    local ____opt_6 = getGlobalConfiguration().integrations.ollama
    if ____opt_6 and ____opt_6.enabled then
        local result = ____exports.isOllamaIntegrationAllowed()
        if not result.success then
            setImmediate(function()
                vim.notify(
                    ("Ollama integration is enabled, but " .. tostring(result.reason)) .. ".",
                    vim.log.levels.ERROR
                )
            end)
        else
            local args = {}
            local config = __TS__ObjectAssign(
                {},
                getOllamaConfig()
            )
            if config.port ~= nil or config.disableAutoPortAlloc == true then
                vim.notify("Because port is manually specified in ollama integration configuration, a port cannot be automatically allocated. This may lead to conflicts between multiple instances of Neovim", vim.log.levels.WARN)
                vim.g.copilot_proxy = "http://localhost:11435"
                vim.g.copilot_proxy_strict_ssl = false
            else
                local port, portSsl, proxyPort, proxyPortSsl = unpack(getOpenPorts({count = 4}))
                config.port = ":" .. tostring(port)
                config["port-ssl"] = ":" .. tostring(portSsl)
                config["proxy-port"] = ":" .. tostring(proxyPort)
                config["proxy-port-ssl"] = ":" .. tostring(proxyPortSsl)
                vim.g.copilot_proxy = "http://localhost:" .. tostring(proxyPortSsl)
                vim.g.copilot_proxy_strict_ssl = false
            end
            for key in pairs(config) do
                local value = config[key]
                args[#args + 1] = "--" .. key
                if type(value) ~= "boolean" then
                    args[#args + 1] = tostring(value)
                end
            end
            local command = (ollamaCopilotExecutable .. " ") .. table.concat(args, " ")
            local function ioHandler(_id, data, name)
            end
            vim.fn.jobstart(
                command,
                {
                    on_stdout = ioHandler,
                    on_stderr = ioHandler,
                    on_stdin = ioHandler,
                    on_exit = function(id, code, signal)
                        vim.notify(
                            (("Ollama exited with code " .. tostring(code)) .. " and signal ") .. signal,
                            vim.log.levels.ERROR
                        )
                    end
                }
            )
        end
    end
end
return ____exports
 end,
["lua.integrations.portable-appimage"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local function getAppImageConfigData()
    return {appDir = os.getenv("APPDIR")}
end
local function injectSTDPathOverride()
    vim.fn.stdpath = function(target)
        return "/tmp/winvim/" .. target
    end
end
function ____exports.enablePortableAppImageLogic()
    local appImageEnvironment = getAppImageConfigData()
    if appImageEnvironment.appDir ~= nil then
        injectSTDPathOverride()
    end
end
return ____exports
 end,
["lua.plugins.init"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____configuration = require("lua.helpers.configuration.index")
local getGlobalConfiguration = ____configuration.getGlobalConfiguration
function ____exports.getPlugins()
    local globalConfig = getGlobalConfiguration()
    local result = {}
    local targets = {
        {include = "copilot-lualine", key = "copilotLuaLine"},
        {include = "nui"},
        {key = "screenkey", include = "screenkey"},
        {key = "outline", include = "outline"},
        {key = "presence", include = "presence"},
        {key = "dropBar", include = "dropbar"},
        {key = "gotoPreview", include = "goto-preview"},
        {key = "treesitterContext", include = "treesitter-context"},
        {key = "fidget", include = "fidget"},
        {key = "hex", include = "hex"},
        {key = "tinyInlineDiagnostic", include = "tiny-inline-diagnostic"},
        {key = "flatten", include = "flatten"},
        {key = "rest", include = "rest"},
        {key = "hlchunk", include = "hlchunk"},
        {key = "overseer", include = "overseer"},
        {key = "nvimDapVirtualText", include = "dap-virtual-text"},
        {key = "tsContextCommentString", include = "ts-context-commentstring"},
        {key = "neogen", include = "neogen"},
        {key = "lightbulb", include = "lightbulb"},
        {key = "dbee", include = "dbee"},
        {key = "crates", include = "crates"},
        {key = "todoComments", include = "todo-comments"},
        {key = "iconPicker", include = "icon-picker"},
        {key = "treesj", include = "treesj"},
        {include = "tokyonight"},
        {include = "catppuccin"},
        {include = "theme-flow"},
        {include = "kanagawa"},
        {include = "nord"},
        {include = "poimandres"},
        {include = "bluloco"},
        {include = "midnight"},
        {key = "treeSitter", include = "treesitter"},
        {key = "lspConfig", include = "lspconfig"},
        {key = "autoPairs", include = "autopairs"},
        {key = "floatTerm", include = "floatterm"},
        {key = "nvimTree", include = "nvim-tree"},
        {key = "telescope", include = "telescope"},
        {key = "mason", include = "mason"},
        {key = "cmp", include = "cmp"},
        {key = "lspLines", include = "lsp_lines"},
        {key = "lspUI", include = "lspUI"},
        {key = "rustaceanvim", include = "rustaceanvim"},
        {key = "lspSignature", include = "lsp_signature"},
        {key = "indentBlankline", include = "indent-blankline"},
        {key = "treeDevIcons", include = "nvim-tree-devicons"},
        {key = "luaLine", include = "lualine"},
        {key = "barBar", include = "barbar"},
        {key = "ufo", include = "ufo"},
        {key = "comment", include = "comment"},
        {key = "marks", include = "marks"},
        {key = "trouble", include = "trouble"},
        {key = "glance", include = "glance"},
        {key = "nvimDapUI", include = "nvim-dap-ui"},
        {key = "diffView", include = "diffview"},
        {key = "lazygit", include = "lazygit"},
        {key = "noice", include = "noice"},
        {key = "copilot", include = "copilot"},
        {key = "actionsPreview", include = "actions-preview"},
        {key = "fireNvim", include = "firenvim"},
        {key = "nvimNotify", include = "nvim-notify"},
        {key = "markdownPreview", include = "markdown-preview"},
        {key = "gitBrowse", include = "git-browse"},
        {key = "obsidian", include = "obsidian"},
        {key = "undoTree", include = "undotree"},
        {key = "octo", include = "octo"},
        {key = "leap", include = "leap"},
        {key = "cSharp", include = "csharp"},
        {key = "telescopeUISelect", include = "telescope-ui-select"},
        {key = "masonNvimDap", include = "mason-nvim-dap"},
        {key = "timeTracker", include = "time-tracker"},
        {key = "wakaTime", include = "wakatime"},
        {key = "surround", include = "surround"},
        {key = "tsAutoTag", include = "ts-autotag"},
        {key = "ultimateAutoPair", include = "ultimate-autopair"},
        {key = "rainbowDelimiters", include = "rainbow-delimiters"},
        {key = "markview", include = "markview"},
        {key = "symbolUsage", include = "symbol-usage"},
        {key = "neotest", include = "neotest"},
        {key = "navic", include = "navic"},
        {key = "illuminate", include = "illuminate"},
        {key = "timerly", include = "timerly"}
    }
    local activeTargets = __TS__ArrayFilter(
        targets,
        function(____, x)
            local ____temp_2 = x.key == nil
            if not ____temp_2 then
                local ____opt_0 = globalConfig.packages[x.key]
                ____temp_2 = ____opt_0 and ____opt_0.enabled
            end
            return ____temp_2
        end
    )
    vim.api.nvim_create_user_command(
        "WinPlugStats",
        function()
            vim.notify(
                ((("Using " .. tostring(#targets)) .. " plugin definitions, ") .. tostring(#activeTargets)) .. " of which are enabled",
                vim.log.levels.INFO
            )
        end,
        {nargs = 0}
    )
    for ____, target in ipairs(activeTargets) do
        do
            local function ____catch()
                vim.notify(((("Failed to include plugin '" .. (target.key or target.include)) .. "' (") .. target.include) .. ")")
            end
            local ____try = pcall(function()
                local canLoad = true
                if target.runtimeCapabilityChecker ~= nil then
                    if not target.runtimeCapabilityChecker() then
                        canLoad = false
                    end
                end
                if canLoad then
                    result[#result + 1] = require("lua.plugins." .. target.include).default
                end
            end)
            if not ____try then
                ____catch()
            end
        end
    end
    return result
end
return ____exports
 end,
["lua.shims.console.index"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
function ____exports.insertConsoleShims()
    if _G.console == nil then
        _G.console = {
            log = function(message)
                vim.notify(message, vim.log.levels.INFO)
            end,
            warn = function(message)
                vim.notify(message, vim.log.levels.WARN)
            end,
            error = function(message)
                vim.notify(message, vim.log.levels.ERROR)
            end
        }
    end
end
return ____exports
 end,
["lua.shims.json.index"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
function ____exports.insertJSONShims()
    if _G.JSON == nil then
        _G.JSON = {}
    end
    _G.JSON.stringify = function(____, value, replacer)
        if replacer ~= nil then
            vim.notify("JSON.stringify replacer param does not have shim implementation", vim.log.levels.ERROR)
        end
        return vim.json.encode(value)
    end
    _G.JSON.parse = function(____, text, reviver)
        if reviver ~= nil then
            vim.notify("JSON.parse reviver param does not have shim implementation", vim.log.levels.ERROR)
        end
        vim.json.decode(text)
    end
end
return ____exports
 end,
["main"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____custom = require("lua.custom.index")
local setupCustomLogic = ____custom.setupCustomLogic
local ____configuration = require("lua.helpers.configuration.index")
local getGlobalConfiguration = ____configuration.getGlobalConfiguration
local ____font = require("lua.helpers.font.index")
local setGUIFont = ____font.setGUIFont
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local ____diffopt = require("lua.helpers.vim-feature-unwrappers.diffopt")
local createDiffOptString = ____diffopt.createDiffOptString
local ____hyprland = require("lua.integrations.hyprland")
local Hyprland = ____hyprland.Hyprland
local isDesktopHyprland = ____hyprland.isDesktopHyprland
local ____neovide = require("lua.integrations.neovide")
local getNeovideExtendedVimContext = ____neovide.getNeovideExtendedVimContext
local ____ollama = require("lua.integrations.ollama")
local ollamaIntegration = ____ollama.ollamaIntegration
local ____portable_2Dappimage = require("lua.integrations.portable-appimage")
local enablePortableAppImageLogic = ____portable_2Dappimage.enablePortableAppImageLogic
local ____init = require("lua.plugins.init")
local getPlugins = ____init.getPlugins
local ____console = require("lua.shims.console.index")
local insertConsoleShims = ____console.insertConsoleShims
local ____json = require("lua.shims.json.index")
local insertJSONShims = ____json.insertJSONShims
local ____mainLoopCallbacks = require("lua.shims.mainLoopCallbacks")
local insertMainLoopCallbackShims = ____mainLoopCallbacks.insertMainLoopCallbackShims
local setImmediate = ____mainLoopCallbacks.setImmediate
local ____theme = require("lua.theme")
local THEME_APPLIERS = ____theme.THEME_APPLIERS
insertJSONShims()
insertConsoleShims()
insertMainLoopCallbackShims()
enablePortableAppImageLogic()
local function setupNeovide()
    local vim = getNeovideExtendedVimContext()
    if vim.g.neovide then
        vim.g.neovide_scale_factor = 0.85
        vim.g.neovide_detach_on_quit = "always_detach"
        if isDesktopHyprland() then
            local ____array_0 = __TS__SparseArrayNew(unpack(Hyprland.getRefreshRates()))
            __TS__SparseArrayPush(____array_0, 60)
            local targetRefresh = math.max(unpack({__TS__SparseArraySpread(____array_0)}))
            vim.g.neovide_refresh_rate = targetRefresh
        end
        setGUIFont("VictorMono_Nerd_Font_Mono", 14)
    end
end
local function setupLazy()
    local lazyPath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazyPath) then
        local repo = "https://github.com/folke/lazy.nvim.git"
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            repo,
            "--branch=stable",
            lazyPath
        })
    end
    vim.opt.rtp:prepend(lazyPath)
end
vim.opt.diffopt = createDiffOptString({
    internal = true,
    filler = true,
    closeoff = true,
    indentHeuristic = true,
    lineMatch = 60,
    algorithm = "histogram"
})
setupNeovide()
ollamaIntegration()
setupLazy()
local lazy = useExternalModule("lazy")
lazy.setup(getPlugins())
THEME_APPLIERS[getGlobalConfiguration().theme.key]()
vim.opt.clipboard = "unnamedplus"
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "number"
vim.opt.numberwidth = 2
vim.opt.ruler = true
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
require("mappings")
setImmediate(setupCustomLogic)
return ____exports
 end,
["lua.helpers.one-off.index"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____fs = require("lua.shims.fs.index")
local fs = ____fs.fs
local dataPath = vim.fn.stdpath("data") .. "/winvim/one-off"
vim.fn.system({"mkdir", "-p", dataPath})
function ____exports.oneOffFunction(key, only_once, not_first_time)
    local path = (dataPath .. "/") .. key
    if fs.existsSync(path) then
        if not_first_time ~= nil then
            not_first_time()
        end
    else
        fs.writeFileSync(path, "")
        only_once()
    end
end
return ____exports
 end,
["lua.plugins.actions-preview"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
function ____exports.getActionsPreview()
    local target = "actions-preview"
    local module = useExternalModule(target)
    return module
end
local plugin = {[1] = "aznhe21/actions-preview.nvim", event = "VeryLazy"}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.csharp"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____configuration = require("lua.helpers.configuration.index")
local getGlobalConfiguration = ____configuration.getGlobalConfiguration
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local ____mainLoopCallbacks = require("lua.shims.mainLoopCallbacks")
local setImmediate = ____mainLoopCallbacks.setImmediate
function ____exports.getCSharp()
    return useExternalModule("csharp")
end
local plugin = {
    [1] = "iabdelkareem/csharp.nvim",
    dependencies = {"williamboman/mason.nvim", "mfussenegger/nvim-dap", "Tastyep/structlog.nvim"},
    config = function()
        local ____opt_0 = getGlobalConfiguration().packages.mason
        if ____opt_0 and ____opt_0.enabled then
            if not vim.fn.executable("fd") then
                setImmediate(function()
                    console.error("[plugin/cSharp] Initialization not allowed: fd is required, but cannot be found in the current path.")
                end)
            else
                ____exports.getCSharp().setup()
            end
        else
            setImmediate(function()
                console.error("[plugin/cSharp] Initialization not allowed: mason is required, but has been disabled.")
            end)
        end
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.nvim-dap-ui"] = function(...) 
local ____lualib = require("lualib_bundle")
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__New = ____lualib.__TS__New
local __TS__ArraySome = ____lualib.__TS__ArraySome
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____configuration = require("lua.helpers.configuration.index")
local getGlobalConfiguration = ____configuration.getGlobalConfiguration
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
function ____exports.getDap()
    local target = "dap"
    local dapui = useExternalModule(target)
    return dapui
end
function ____exports.getDapUI()
    local target = "dapui"
    local dapui = useExternalModule(target)
    return dapui
end
local function bindDapUIEvents()
    local dap = ____exports.getDap()
    local dapui = ____exports.getDapUI()
    dap.listeners.before.attach.dapui_config = function()
        dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
    end
end
local cppExePath
local function getCPPTargetExecutable()
    if cppExePath == nil then
        cppExePath = vim.fn.input(
            "Path to executable: ",
            vim.fn.getcwd() .. "/",
            "file"
        )
        if not vim.loop.fs_stat(cppExePath) then
            cppExePath = nil
            error(
                __TS__New(Error, "File not found"),
                0
            )
        end
    end
    return cppExePath
end
vim.api.nvim_create_autocmd(
    "DirChanged",
    {callback = function()
        cppExePath = nil
    end}
)
local function createOrUseArray(root, arrayKey, callback)
    if root[arrayKey] == nil or root[arrayKey] == nil then
        root[arrayKey] = {}
    end
    return callback(root[arrayKey])
end
local function configureLanguages()
    local dap = ____exports.getDap()
    if vim.fn.executable("codelldb") == 1 then
        dap.adapters.lldb = {type = "server", port = "${port}", host = "127.0.0.1", executable = {command = "codelldb", args = {"--port", "${port}"}}}
        for ____, language in ipairs({"c", "cpp", "rust"}) do
            createOrUseArray(
                dap.configurations,
                language,
                function(languageConfig)
                    languageConfig[#languageConfig + 1] = {
                        name = "Launch",
                        type = "lldb",
                        request = "launch",
                        program = getCPPTargetExecutable,
                        cwd = "${workspaceFolder}",
                        stopOnEntry = false,
                        args = function()
                            local result = {}
                            result[#result + 1] = "test"
                            return result
                        end,
                        runInTerminal = true
                    }
                end
            )
        end
    end
    if vim.fn.executable("js-debug-adapter") == 1 then
        dap.adapters["pwa-node"] = {type = "server", host = "::1", port = 8123, executable = {command = "js-debug-adapter"}}
        vim.notify("JS Debug Adapter installed, but no DAP configuration uses it.", vim.log.levels.WARN)
    end
    if vim.fn.executable("node-debug2-adapter") == 1 then
        dap.adapters.node2 = {name = "NodeJS Debug", type = "executable", command = "node-debug2-adapter"}
        for ____, language in ipairs({"javascript", "typescript"}) do
            dap.configurations[language] = {{
                type = "node2",
                request = "launch",
                name = "Launch file",
                program = "${file}",
                cwd = "${workspaceFolder}",
                runtimeExecutable = "node",
                outDir = "dist",
                args = {"${file}"},
                sourceMap = true,
                skipFiles = {"<node_internals>/**", "node_modules/**"},
                protocol = "inspector",
                outFiles = {"${workspaceFolder}/dist/*.js"}
            }}
        end
    end
end
local function configureActiveLanguages()
    local config = getGlobalConfiguration()
    local ____opt_0 = config.packages.nvimDapUI
    local dapConfig = ____opt_0 and ____opt_0.config
    if dapConfig == nil then
        vim.notify("DAP configuration undefined. Unable to continue setup.", vim.log.levels.ERROR)
        return
    end
    local dap = ____exports.getDap()
    local ____opt_2 = config.targetEnvironments["c/c++"]
    if ____opt_2 and ____opt_2.enabled then
        local LLDB_PORT = dapConfig.lldb.port
        dap.adapters.lldb = {
            type = "server",
            port = LLDB_PORT,
            host = dapConfig.lldb.host or "127.0.0.1",
            executable = {
                command = dapConfig.lldb.executable or "codelldb",
                args = {
                    "--port",
                    tostring(LLDB_PORT),
                    unpack(dapConfig.lldb.additionalArgs or ({}))
                }
            }
        }
        for ____, language in ipairs({"cpp", "c"}) do
            dap.configurations[language] = {{
                name = "Launch",
                type = "lldb",
                request = "launch",
                program = getCPPTargetExecutable,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
                args = {},
                runInTerminal = true
            }}
        end
    end
    local possibleTargets = {"nodejs", "javascript", "typescript"}
    if __TS__ArraySome(
        possibleTargets,
        function(____, x)
            local ____opt_4 = config.targetEnvironments[x]
            local ____temp_6 = ____opt_4 and ____opt_4.enabled
            if ____temp_6 == nil then
                ____temp_6 = false
            end
            return ____temp_6
        end
    ) then
        dap.adapters["pwa-node"] = {type = "server", host = "::1", port = 8123, executable = {command = "js-debug-adapter"}}
        dap.adapters.node2 = {name = "NodeJS Debug", type = "executable", command = "node-debug2-adapter"}
        for ____, language in ipairs({"javascript", "typescript"}) do
            local ____opt_7 = config.targetEnvironments[language]
            if ____opt_7 and ____opt_7.enabled then
                dap.configurations[language] = {{
                    type = "node2",
                    request = "launch",
                    name = "Launch file",
                    program = "${file}",
                    cwd = "${workspaceFolder}",
                    runtimeExecutable = "node",
                    outDir = "dist",
                    args = {"${file}"},
                    sourceMap = true,
                    skipFiles = {"<node_internals>/**", "node_modules/**"},
                    protocol = "inspector",
                    outFiles = {"${workspaceFolder}/dist/*.js"}
                }}
            end
        end
    end
end
local plugin = {
    [1] = "rcarriga/nvim-dap-ui",
    dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
    config = function()
        ____exports.getDapUI().setup({})
        bindDapUIEvents()
        configureLanguages()
        ____exports.getDap().defaults.fallback.exception_breakpoints = {"uncaught", "raised"}
    end
}
____exports.default = plugin
return ____exports
 end,
["mappings"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____tmux = require("lua.custom.tmux.index")
local isRunningInsideTmux = ____tmux.isRunningInsideTmux
local selectCustomTmuxScope = ____tmux.selectCustomTmuxScope
local ____configuration = require("lua.helpers.configuration.index")
local getGlobalConfiguration = ____configuration.getGlobalConfiguration
local ____keymap = require("lua.helpers.keymap.index")
local applyKeyMapping = ____keymap.applyKeyMapping
local ____one_2Doff = require("lua.helpers.one-off.index")
local oneOffFunction = ____one_2Doff.oneOffFunction
local ____actions_2Dpreview = require("lua.plugins.actions-preview")
local getActionsPreview = ____actions_2Dpreview.getActionsPreview
local ____csharp = require("lua.plugins.csharp")
local getCSharp = ____csharp.getCSharp
local ____nvim_2Ddap_2Dui = require("lua.plugins.nvim-dap-ui")
local getDap = ____nvim_2Ddap_2Dui.getDap
local getDapUI = ____nvim_2Ddap_2Dui.getDapUI
vim.g.mapleader = " "
vim.cmd("map w <Nop>")
vim.cmd("map W <Nop>")
applyKeyMapping({
    mode = "n",
    inputStroke = "<leader>i",
    action = function()
        vim.lsp.inlay_hint.enable(
            not vim.lsp.inlay_hint.is_enabled({0}),
            {0}
        )
    end
})
local MOVEMENT_DIRECTION_KEYS = {left = {key = "h", command = "<Left>"}, right = {key = "l", command = "<Right>"}, up = {key = "k", command = "<Up>"}, down = {key = "j", command = "<Down>"}}
for direction in pairs(MOVEMENT_DIRECTION_KEYS) do
    local key = MOVEMENT_DIRECTION_KEYS[direction]
    applyKeyMapping({mode = "i", inputStroke = ("<C-" .. key.key) .. ">", outputStroke = key.command, options = {desc = "move " .. direction}})
end
for direction in pairs(MOVEMENT_DIRECTION_KEYS) do
    local key = MOVEMENT_DIRECTION_KEYS[direction]
    applyKeyMapping({mode = "n", inputStroke = ("<C-" .. key.key) .. ">", outputStroke = "<C-w>" .. key.key, options = {desc = "switch window " .. direction}})
end
local config = getGlobalConfiguration()
local function getPackage(key)
    local target = config.packages[key]
    if target == nil then
        return {false, nil}
    else
        return {target.enabled, target.config}
    end
end
do
    local enabled = unpack(getPackage("barBar"))
    if enabled then
        applyKeyMapping({mode = "n", inputStroke = "<leader>x", outputStroke = "<cmd>BufferClose<CR>", options = {desc = "Close current buffer"}})
        applyKeyMapping({mode = "n", inputStroke = "<Tab>", outputStroke = "<cmd>BufferNext<CR>", options = {desc = "Switch buffer"}})
        applyKeyMapping({mode = "n", inputStroke = "<A-h>", outputStroke = "<cmd>:BufferPrevious <CR>", options = {desc = "previous buffer"}})
        applyKeyMapping({mode = "n", inputStroke = "<A-l>", outputStroke = "<cmd>:BufferNext <CR>", options = {desc = "next buffer"}})
    else
        applyKeyMapping({mode = "n", inputStroke = "<leader>x", outputStroke = "<cmd>:bd<CR>:bnext<CR>", options = {desc = "Close current buffer"}})
        applyKeyMapping({mode = "n", inputStroke = "<A-h>", outputStroke = "<cmd>:bprev <CR>", options = {desc = "previous buffer"}})
        applyKeyMapping({mode = "n", inputStroke = "<A-l>", outputStroke = "<cmd>:bnext <CR>", options = {desc = "next buffer"}})
        applyKeyMapping({mode = "n", inputStroke = "<Tab>", outputStroke = "<cmd>:bnext<CR>", options = {desc = "Switch next buffer"}})
    end
end
applyKeyMapping({mode = "n", inputStroke = "<leader>s", outputStroke = "<cmd>:vsplit<CR>", options = {desc = "vertical split"}})
applyKeyMapping({mode = "n", inputStroke = "<leader>h", outputStroke = "<cmd>:split<CR>", options = {desc = "horizontal split"}})
applyKeyMapping({mode = "n", inputStroke = "<Esc>", outputStroke = "<cmd>noh<CR>", options = {desc = "general clear highlights"}})
applyKeyMapping({mode = "n", inputStroke = "<C-n>", outputStroke = "<cmd>NvimTreeToggle<CR>", options = {desc = "toggle file tree"}})
do
    local enabled = unpack(getPackage("floatTerm"))
    if enabled then
        for ____, mode in ipairs({"n", "i", "t"}) do
            applyKeyMapping({mode = mode, inputStroke = "<A-i>", outputStroke = "<cmd>FloatermToggle __builtin_floating<CR>", options = {desc = "toggle floating terminal"}})
        end
        applyKeyMapping({mode = "t", inputStroke = "<A-h>", outputStroke = "<cmd>FloatermPrev<CR>", options = {desc = "terminal previous terminal"}})
        if not isRunningInsideTmux() then
            applyKeyMapping({
                mode = "n",
                inputStroke = "<c-b>s",
                action = function()
                    selectCustomTmuxScope()
                end,
                options = {desc = "Select custom tmux scope"}
            })
        end
        applyKeyMapping({mode = "t", inputStroke = "<A-l>", outputStroke = "<cmd>FloatermNext<CR>", options = {desc = "terminal next terminal"}})
        applyKeyMapping({mode = "t", inputStroke = "<A-n>", outputStroke = "<cmd>FloatermNew<CR>", options = {desc = "terminal new terminal"}})
        applyKeyMapping({mode = "t", inputStroke = "<A-k>", outputStroke = "<cmd>FloatermKill<CR>", options = {desc = "terminal new terminal"}})
    end
end
applyKeyMapping({mode = "t", inputStroke = "<C-x>", outputStroke = "<C-\\><C-N>", options = {desc = "terminal escape terminal mode"}})
do
    local enabled = unpack(getPackage("telescope"))
    if enabled then
        applyKeyMapping({mode = "n", inputStroke = "<leader>ff", outputStroke = "<cmd>Telescope find_files <CR>", options = {desc = "Find files"}})
        applyKeyMapping({mode = "n", inputStroke = "<leader>fw", outputStroke = "<cmd>Telescope live_grep <CR>", options = {desc = "Live grep"}})
        applyKeyMapping({mode = "n", inputStroke = "<leader>fb", outputStroke = "<cmd>Telescope buffers <CR>", options = {desc = "Find buffers"}})
        applyKeyMapping({mode = "n", inputStroke = "<leader>cm", outputStroke = "<cmd>Telescope git_commits <CR>", options = {desc = "Git commits"}})
        applyKeyMapping({mode = "n", inputStroke = "<leader>gt", outputStroke = "<cmd>Telescope git_status <CR>", options = {desc = "Git status"}})
        applyKeyMapping({mode = "n", inputStroke = "<leader>fz", outputStroke = "<cmd>Telescope current_buffer_fuzzy_find <CR>", options = {desc = "Find in current buffer"}})
    end
end
do
    local enabled = unpack(getPackage("lspConfig"))
    if enabled then
        applyKeyMapping({
            mode = "n",
            inputStroke = "<leader>fm",
            action = function()
                vim.lsp.buf.format({async = true})
            end,
            options = {desc = "LSP Formatting"}
        })
        applyKeyMapping({
            mode = "n",
            inputStroke = "<leader>,",
            action = function()
                vim.lsp.buf.signature_help()
                vim.lsp.buf.hover()
            end,
            options = {desc = "Show LSP signature & type info"}
        })
        applyKeyMapping({
            mode = "n",
            inputStroke = "<leader><c-,>",
            action = function()
                vim.diagnostic.open_float({border = "rounded"})
            end,
            options = {desc = "Show LSP signature & type info"}
        })
    end
end
do
    local enabled = unpack(getPackage("comments"))
    if enabled then
        applyKeyMapping({
            mode = "n",
            inputStroke = "<leader>/",
            action = function()
                vim.cmd("norm gcc")
            end,
            options = {desc = "toggle comment"}
        })
        applyKeyMapping({
            mode = "v",
            inputStroke = "<leader>/",
            action = function()
                vim.cmd("norm gcc")
            end,
            options = {desc = "toggle comment"}
        })
    else
        oneOffFunction(
            "warn-comments-disabled",
            function()
                vim.notify("Comments plugin is disabled", vim.log.levels.WARN)
            end
        )
    end
end
local ____opt_0 = config.packages.trouble
if ____opt_0 and ____opt_0.enabled then
    applyKeyMapping({mode = "n", inputStroke = "<leader>tdd", outputStroke = ":Trouble diagnostics toggle<CR>", options = {silent = true}})
end
if true then
    applyKeyMapping({
        mode = "n",
        inputStroke = "<F2>",
        action = function()
            vim.lsp.buf.rename()
        end,
        options = {desc = "rename"}
    })
end
local ____opt_2 = config.packages.glance
if ____opt_2 and ____opt_2.enabled then
    applyKeyMapping({mode = "n", inputStroke = "<leader>glr", outputStroke = ":Glance references<CR>", options = {desc = "Open references"}})
    applyKeyMapping({mode = "n", inputStroke = "<leader>gld", outputStroke = ":Glance definitions<CR>", options = {desc = "Open definitions"}})
    applyKeyMapping({mode = "n", inputStroke = "<leader>gltd", outputStroke = ":Glance type_definitions<CR>", options = {desc = "Open type definitions"}})
    applyKeyMapping({mode = "n", inputStroke = "<leader>gli", outputStroke = ":Glance implementations<CR>", options = {desc = "Open implementations"}})
end
if config.packages.nvimDapUI then
    applyKeyMapping({mode = "n", inputStroke = "<leader>db", outputStroke = ":DapToggleBreakpoint<CR>", options = {desc = "Toggle breakpoint"}})
    applyKeyMapping({
        mode = "n",
        inputStroke = "<leader>dr",
        action = function()
            local ____opt_4 = getGlobalConfiguration().packages.nvimTree
            if ____opt_4 and ____opt_4.enabled then
                vim.cmd("NvimTreeClose")
            end
            local ____temp_8 = vim.bo.filetype == "cs"
            if ____temp_8 then
                local ____opt_6 = getGlobalConfiguration().packages.cSharp
                ____temp_8 = ____opt_6 and ____opt_6.enabled
            end
            if ____temp_8 then
                if getDap().status() == "Running" then
                    vim.cmd("DapContinue")
                else
                    getCSharp().debug_project()
                end
            else
                vim.cmd("DapContinue")
            end
        end,
        options = {desc = "Start or continue the debugger"}
    })
    applyKeyMapping({
        mode = "n",
        inputStroke = "<leader>dt",
        action = function()
            getDapUI().toggle()
        end,
        options = {desc = "Toggle debugger UI"}
    })
    applyKeyMapping({mode = "n", inputStroke = "<leader>dsi", outputStroke = ":DapStepInto<CR>", options = {desc = "Step into"}})
    applyKeyMapping({mode = "n", inputStroke = "<leader>dso", outputStroke = ":DapStepOver<CR>", options = {desc = "Step over"}})
    applyKeyMapping({mode = "n", inputStroke = "<leader>dsO", outputStroke = ":DapStepOut<CR>", options = {desc = "Step out"}})
    applyKeyMapping({
        mode = "n",
        inputStroke = "<leader>dsc",
        action = function()
            getDap().run_to_cursor()
        end,
        options = {desc = "Step to cursor"}
    })
    applyKeyMapping({
        mode = "v",
        inputStroke = "<leader>e",
        action = function()
            getDapUI().eval()
        end,
        options = {desc = "Evaluate selected statement"}
    })
    applyKeyMapping({
        mode = "n",
        inputStroke = "<leader>e",
        action = function()
            getDapUI().eval()
        end,
        options = {desc = "Evaluate selected statement"}
    })
end
local ____opt_9 = config.packages.actionsPreview
if ____opt_9 and ____opt_9.enabled then
    applyKeyMapping({
        mode = "n",
        inputStroke = ".",
        action = function()
            getActionsPreview().code_actions()
        end,
        options = {desc = "Show code actions"}
    })
end
local ____opt_11 = config.packages.lazyGit
if ____opt_11 and ____opt_11.enabled then
    applyKeyMapping({mode = "n", inputStroke = "<leader>lg", outputStroke = "<cmd>LazyGit<CR>", options = {desc = "Show code actions"}})
end
vim.cmd("map q <Nop>")
return ____exports
 end,
["lua.custom.settings.index"] = function(...) 
local ____lualib = require("lualib_bundle")
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__New = ____lualib.__TS__New
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__ObjectKeys = ____lualib.__TS__ObjectKeys
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____configuration = require("lua.helpers.configuration.index")
local getGlobalConfiguration = ____configuration.getGlobalConfiguration
local ____nui = require("lua.plugins.nui")
local useNUI = ____nui.useNUI
local function configurePlugin(pluginKey)
    local nui = useNUI()
    local configuration = getGlobalConfiguration().packages[pluginKey]
    if configuration == nil then
        error(
            __TS__New(Error, "Failed to locate plugin " .. pluginKey),
            0
        )
    end
    console.log("good")
end
local function showSettingsMenu()
    local nui = useNUI()
    local modules = __TS__ArrayMap(
        __TS__ArrayMap(
            __TS__ObjectKeys(getGlobalConfiguration().packages),
            function(____, x) return __TS__ObjectAssign(
                {},
                getGlobalConfiguration().packages[x],
                {key = x}
            ) end
        ),
        function(____, x) return nui.Menu.item(x.key, x) end
    )
    local menu = nui.Menu(
        {position = "50%", size = {width = 33, height = 10}, border = {style = "single", text = {top = "Configure Plugin"}}},
        {
            on_submit = function(item)
                if item ~= nil then
                    configurePlugin(item.key)
                end
            end,
            lines = modules
        }
    )
    menu:mount()
end
function ____exports.initCustomSettingsSystem()
    vim.api.nvim_create_user_command(
        "ShowSettings",
        function()
            showSettingsMenu()
        end,
        {}
    )
end
return ____exports
 end,
["lua.helpers.text.center"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
function ____exports.centerText(input, width, spacer)
    if spacer == nil then
        spacer = " "
    end
    while #input + #spacer < width do
        input = (spacer .. input) .. spacer
    end
    return input
end
return ____exports
 end,
["lua.helpers.typed-autocmd.index"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
function ____exports.useAutocmd(key, callback)
    vim.api.nvim_create_autocmd(key, {callback = callback})
end
return ____exports
 end,
["lua.helpers.window-dimensions.index"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
function ____exports.actualBufferDimensions(target)
    local window = vim.fn.bufwinid(target)
    local wininfos = vim.fn.getwininfo(window)
    if wininfos == nil then
        return nil
    end
    local wininfo = wininfos[1]
    return {actualWidth = wininfo.width - wininfo.textoff}
end
return ____exports
 end,
["lua.plugins.autopairs"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local plugin = {[1] = "windwp/nvim-autopairs", event = "InsertEnter", config = true}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.barbar"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local plugin = {
    [1] = "romgrk/barbar.nvim",
    dependencies = {"lewis6991/gitsigns.nvim", "nvim-tree/nvim-web-devicons"},
    init = function()
        vim.g.barbar_auto_setup = false
    end,
    opts = {animation = true, insert_at_start = true, auto_hide = 1}
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.bluloco"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local plugin = {
    [1] = "uloco/bluloco.nvim",
    lazy = false,
    priority = 1000,
    dependencies = {"rktjmp/lush.nvim"},
    config = function()
        useExternalModule("bluloco").setup({
            style = "dark",
            terminal = vim.fn.has("gui_running") == 1,
            guicursor = true
        })
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.catppuccin"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local plugin = {[1] = "catppuccin/nvim", priority = 1000, name = "catppuccin"}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.cmp"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local KIND_ICONS = {
    Text = "",
    Method = "󰆧",
    Function = "󰊕",
    Constructor = "",
    Field = "󰇽",
    Variable = "󰂡",
    Class = "󰠱",
    Interface = "",
    Module = "",
    Property = "󰜢",
    Unit = "",
    Value = "󰎠",
    Enum = "",
    Keyword = "󰌋",
    Snippet = "",
    Color = "󰏘",
    File = "󰈙",
    Reference = "",
    Folder = "󰉋",
    EnumMember = "",
    Constant = "󰏿",
    Struct = "",
    Event = "",
    Operator = "󰆕",
    TypeParameter = "󰅲"
}
function ____exports.getCMP()
    local cmp = useExternalModule("cmp")
    return cmp
end
local plugin = {
    [1] = "Walter-Neils/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "neovim/nvim-lspconfig",
        "onsails/lspkind.nvim",
        "hrsh7th/cmp-vsnip",
        "hrsh7th/vim-vsnip"
    },
    config = function()
        local cmp = ____exports.getCMP()
        cmp.setup({
            view = {entries = {vertical_positioning = "above"}},
            window = {completion = {winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None", col_offset = -3, side_padding = 0}},
            formatting = {format = function(_entry, vim_item)
                local target_icon = KIND_ICONS[vim_item.kind]
                local icon = target_icon or "?"
                icon = (" " .. icon) .. " "
                vim_item.menu = ("  (" .. tostring(vim_item.kind)) .. ")  "
                vim_item.kind = string.format("%s %s", icon, vim_item.kind)
                return vim_item
            end},
            snippet = {expand = function(args)
                vim.fn["vsnip#anonymous"](args.body)
            end},
            sources = cmp.config.sources({{name = "nvim_lsp"}}),
            mapping = {
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(1),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({select = false})
            }
        })
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.ts-context-commentstring"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
function ____exports.useTSContextCommentString()
    return useExternalModule("ts_context_commentstring")
end
local plugin = {
    [1] = "JoosepAlviste/nvim-ts-context-commentstring",
    event = "BufRead",
    config = function()
        ____exports.useTSContextCommentString().setup({enable_autocmd = false})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.comment"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local function getComments()
    return useExternalModule("Comment")
end
local plugin = {
    [1] = "numToStr/Comment.nvim",
    event = "BufRead",
    config = function()
        getComments().setup({pre_hook = useExternalModule("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.copilot-lualine"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local plugin = {[1] = "AndreM222/copilot-lualine"}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.copilot"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____configuration = require("lua.helpers.configuration.index")
local getGlobalConfiguration = ____configuration.getGlobalConfiguration
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local ____ollama = require("lua.integrations.ollama")
local isOllamaIntegrationAllowed = ____ollama.isOllamaIntegrationAllowed
function ____exports.getCopilot()
    local copilot = useExternalModule("copilot")
    return copilot
end
local plugin = {
    [1] = "Walter-Neils/copilot.lua",
    cmd = {"Copilot"},
    event = "InsertEnter",
    config = function()
        local lspConfig = {trace = "verbose", settings = {advanced = {inlineSuggestionCount = 10}}}
        local ____opt_0 = getGlobalConfiguration().integrations.ollama
        if ____opt_0 and ____opt_0.enabled then
            local result = isOllamaIntegrationAllowed()
            if result.success then
            else
                vim.notify("Cannot enable ollama proxy: " .. (result.reason or "[NO REASON PROVIDED]"), vim.log.levels.ERROR)
            end
        end
        ____exports.getCopilot().setup({panel = {enabled = false}, suggestion = {auto_trigger = true, keymap = {accept = "<M-CR>", accept_line = "<M-j>", accept_word = "<M-l>"}}, server_opts_overrides = lspConfig})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.crates"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____configuration = require("lua.helpers.configuration.index")
local getGlobalConfiguration = ____configuration.getGlobalConfiguration
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local function getCrates()
    return useExternalModule("crates")
end
local ____table_bleedingEdge_4
local ____opt_2 = getGlobalConfiguration().packages.crates
local ____opt_0 = ____opt_2 and ____opt_2.config
if ____opt_0 and ____opt_0.bleedingEdge then
    ____table_bleedingEdge_4 = nil
else
    ____table_bleedingEdge_4 = "stable"
end
local plugin = {
    [1] = "saecki/crates.nvim",
    tag = ____table_bleedingEdge_4,
    event = {"BufRead Cargo.toml"},
    config = function()
        getCrates().setup()
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.dap-virtual-text"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local function useNvimDapVirtualText()
    return useExternalModule("nvim-dap-virtual-text")
end
local plugin = {
    [1] = "theHamsta/nvim-dap-virtual-text",
    event = "LspAttach",
    config = function()
        useNvimDapVirtualText().setup()
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.dbee"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local function getDbee()
    return useExternalModule("dbee")
end
local plugin = {
    [1] = "kndndrj/nvim-dbee",
    dependencies = {"MunifTanjim/nui.nvim"},
    build = function()
        return getDbee().install()
    end,
    config = function()
        return getDbee().setup()
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.diffview"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local plugin = {[1] = "sindrets/diffview.nvim", cmd = {"DiffviewOpen"}}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.dropbar"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local plugin = {
    [1] = "Bekaboo/dropbar.nvim",
    dependencies = (function()
        local result = {}
        result.build = "make"
        result[#result + 1] = "nvim-telescope/telescope-fzf-native.nvim"
        return result
    end)()
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.fidget"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local function useFidgetPlugin()
    return useExternalModule("fidget")
end
local plugin = {[1] = "j-hui/fidget.nvim", event = "VeryLazy", opts = {}}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.firenvim"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local plugin = {[1] = "glacambre/firenvim", build = ":call firenvim#install(0)"}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.flatten"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local plugin = {[1] = "willothy/flatten.nvim", config = true, lazy = false, priority = 1001}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.floatterm"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
function ____exports.extendNeovimAPIWithFloattermConfig()
    return vim
end
local plugin = {[1] = "voldikss/vim-floaterm", cmd = {"FloatermNew", "FloatermToggle", "FloatermShow", "FloatermHide"}}
local nvim = ____exports.extendNeovimAPIWithFloattermConfig()
nvim.g.floaterm_title = ""
nvim.g.floaterm_wintype = "float"
nvim.g.floaterm_position = "center"
nvim.g.floaterm_width = 0.999
nvim.g.floaterm_height = 0.999
____exports.default = plugin
return ____exports
 end,
["lua.plugins.git-browse"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local plugin = {[1] = "Morozzzko/git_browse.nvim"}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.glance"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local plugin = {
    [1] = "dnlhc/glance.nvim",
    config = function()
        useExternalModule("glance").setup({})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.goto-preview"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local plugin = {[1] = "rmagatti/goto-preview", event = "BufEnter", opts = {default_mappings = true}, config = true}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.hex"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local function useHexPlugin()
    return useExternalModule("hex")
end
local plugin = {
    [1] = "RaafatTurki/hex.nvim",
    event = "VeryLazy",
    cmd = {"HexDump", "HexAssemble", "HexToggle"},
    config = function()
        if not vim.fn.executable("xxd") then
            vim.notify("xxd utility is required for hex editor functionality", vim.log.levels.ERROR)
            return
        end
        useHexPlugin().setup()
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.hlchunk"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local function useHLChunk()
    return useExternalModule("hlchunk")
end
local plugin = {
    [1] = "shellRaining/hlchunk.nvim",
    event = {"BufReadPre", "BufNewFile"},
    config = function()
        useHLChunk().setup({chunk = {enable = true}})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.icon-picker"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local function getIconPicker()
    return useExternalModule("icon-picker")
end
local plugin = {
    [1] = "ziontee113/icon-picker.nvim",
    event = "VeryLazy",
    config = function()
        getIconPicker().setup({disable_legacy_commands = true})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.illuminate"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local function getIlluminate()
    return useExternalModule("illuminate")
end
local plugin = {
    [1] = "RRethy/vim-illuminate",
    event = "BufEnter",
    config = function()
        getIlluminate().configure({delay = 100})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.indent-blankline"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____configuration = require("lua.helpers.configuration.index")
local getGlobalConfiguration = ____configuration.getGlobalConfiguration
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local plugin = {
    [1] = "lukas-reineke/indent-blankline.nvim",
    version = "^3",
    config = function()
        local ibl = useExternalModule("ibl")
        local ____ibl_setup_3 = ibl.setup
        local ____getGlobalConfiguration_result_packages_hlchunk_enabled_2
        local ____opt_0 = getGlobalConfiguration().packages.hlchunk
        if ____opt_0 and ____opt_0.enabled then
            ____getGlobalConfiguration_result_packages_hlchunk_enabled_2 = false
        else
            ____getGlobalConfiguration_result_packages_hlchunk_enabled_2 = true
        end
        ____ibl_setup_3({scope = {enabled = ____getGlobalConfiguration_result_packages_hlchunk_enabled_2}})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.kanagawa"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local plugin = {[1] = "rebelot/kanagawa.nvim", lazy = false, priority = 1000, opts = {theme = "wave", background = {dark = "dragon", light = "lotus"}}}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.lazygit"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local plugin = {[1] = "kdheepak/lazygit.nvim", cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile"
}, dependencies = {"nvim-lua/plenary.nvim"}, keys = {{[1] = "<leader>lg", [2] = "<cmd>LazyGit<CR>"}}}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.leap"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____keymap = require("lua.helpers.keymap.index")
local keyMappingExists = ____keymap.keyMappingExists
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local function getLeap()
    return useExternalModule("leap")
end
local plugin = {
    [1] = "ggandor/leap.nvim",
    event = "VeryLazy",
    config = function()
        if keyMappingExists("n", "S") then
            vim.notify("Deleting conflicting mapping n::S", vim.log.levels.WARN)
            vim.keymap.del("n", "S")
        end
        if keyMappingExists("n", "s") then
            vim.notify("Deleting conflicting mapping n::s", vim.log.levels.WARN)
            vim.keymap.del("n", "s")
        end
        getLeap().create_default_mappings()
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.lightbulb"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local function getLightbulb()
    return useExternalModule("nvim-lightbulb")
end
local plugin = {
    [1] = "kosayoda/nvim-lightbulb",
    event = "BufRead",
    config = function()
        getLightbulb().setup({autocmd = {enabled = true}})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.lspUI"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local plugin = {
    [1] = "jinzhongjia/LspUI.nvim",
    branch = "main",
    event = "VeryLazy",
    config = function()
        local lspUI = useExternalModule("LspUI")
        lspUI.setup({inlay_hint = {enable = false}})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.lsp_lines"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local plugin = {
    [1] = "ErichDonGubler/lsp_lines.nvim",
    event = "VimEnter",
    config = function()
        useExternalModule("lsp_lines").setup()
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.lsp_signature"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local plugin = {
    [1] = "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    config = function(_, opts)
        local lsp_signature = useExternalModule("lsp_signature")
        lsp_signature.setup({always_trigger = true})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.navic"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____configuration = require("lua.helpers.configuration.index")
local getGlobalConfiguration = ____configuration.getGlobalConfiguration
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local ____typed_2Dautocmd = require("lua.helpers.typed-autocmd.index")
local useAutocmd = ____typed_2Dautocmd.useAutocmd
function ____exports.getNavic()
    local ____opt_0 = getGlobalConfiguration().packages.navic
    if ____opt_0 and ____opt_0.enabled then
        return useExternalModule("nvim-navic")
    else
        return nil
    end
end
useAutocmd(
    "LspAttach",
    function(args)
        local navic = ____exports.getNavic()
        if navic then
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client.server_capabilities.documentSymbolProvider then
                navic.attach(client, args.buf)
            end
        end
    end
)
local plugin = {
    [1] = "SmiteshP/nvim-navic",
    event = "InsertEnter",
    config = function()
        ____exports.getNavic().setup({})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.lspconfig"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__ArrayFind = ____lualib.__TS__ArrayFind
local __TS__Promise = ____lualib.__TS__Promise
local __TS__New = ____lualib.__TS__New
local __TS__AsyncAwaiter = ____lualib.__TS__AsyncAwaiter
local __TS__Await = ____lualib.__TS__Await
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local getConfig, on_attach, environmentKeyToConfig, configureLSP, attachCallbacks, preHooks
local ____configuration = require("lua.helpers.configuration.index")
local getGlobalConfiguration = ____configuration.getGlobalConfiguration
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local ____mainLoopCallbacks = require("lua.shims.mainLoopCallbacks")
local setImmediate = ____mainLoopCallbacks.setImmediate
function getConfig()
    local config = getGlobalConfiguration()
    local lspConfigRoot = config.packages.lspconfig
    local lspConfig = lspConfigRoot.config
    return lspConfig
end
function on_attach(client, bufnr)
    local lspConfig = getConfig()
    if lspConfig.inlayHints.enabled then
        local ____error
        do
            local function ____catch(e)
                ____error = e
            end
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                if client.server_capabilities.inlayHintProvider then
                    if vim.lsp.inlay_hint == nil then
                        vim.notify("Failed to enable inlay hints: neovim builtin inlay_hints unavailable", vim.log.levels.ERROR)
                    else
                        vim.lsp.inlay_hint.enable(true, {bufnr = bufnr})
                    end
                    return true
                else
                    vim.notify("Server does not support inlay hints")
                end
            end)
            if not ____try then
                ____hasReturned, ____returnValue = ____catch(____hasReturned)
            end
            if ____hasReturned then
                return ____returnValue
            end
        end
        vim.notify("Failed to enable LSP hints: " .. tostring(____error))
    end
    for ____, callback in ipairs(attachCallbacks) do
        callback(client, bufnr)
    end
end
function ____exports.getLSPConfig()
    local lspconfig = useExternalModule("lspconfig")
    return lspconfig
end
function environmentKeyToConfig(env)
    local configs = {
        {
            key = "typescript",
            lspKey = "ts_ls",
            required_executable = "typescript-language-server",
            additionalOptions = {
                single_file_support = false,
                root_dir = ____exports.getLSPConfig().util.root_pattern("package.json"),
                settings = {javascript = {inlayHints = {
                    includeInlayEnumMemberValueHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayParameterNameHints = "all",
                    includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayVariableTypeHints = true
                }}, typescript = {inlayHints = {
                    includeInlayEnumMemberValueHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayParameterNameHints = "all",
                    includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayVariableTypeHints = true
                }}}
            }
        },
        {
            key = "deno",
            lspKey = "denols",
            additionalOptions = {root_dir = ____exports.getLSPConfig().util.root_pattern("deno.json", "deno.jsonc")}
        },
        {key = "c/c++", lspKey = "clangd"},
        {key = "markdown", lspKey = "marksman"},
        {key = "lua", lspKey = "lua_ls"},
        {key = "yaml", lspKey = "yamlls", required_executable = "yaml-language-server"},
        {key = "rust", lspKey = "rust_analyzer"},
        {key = "bash", lspKey = "bashls"},
        {key = "python", lspKey = "pyright"},
        {key = "go", lspKey = "gopls"}
    }
    return __TS__ArrayFind(
        configs,
        function(____, x) return x.key == env end
    )
end
function configureLSP()
    return __TS__AsyncAwaiter(function(____awaiter_resolve)
        __TS__Await(__TS__New(
            __TS__Promise,
            function(____, resolve) return setImmediate(resolve) end
        ))
        local lspconfig = ____exports.getLSPConfig()
        local targetEnvironments = getGlobalConfiguration().targetEnvironments
        for targetEnvKey in pairs(targetEnvironments) do
            do
                local ____opt_0 = targetEnvironments[targetEnvKey]
                if not (____opt_0 and ____opt_0.enabled) then
                    goto __continue29
                end
                local config = environmentKeyToConfig(targetEnvKey)
                if config == nil then
                    vim.notify("Failed to locate configuration for environment " .. targetEnvKey, vim.log.levels.WARN)
                else
                    if config.required_executable ~= nil then
                        if vim.fn.executable(config.required_executable) ~= 1 then
                            vim.notify(((("Cannot enable LSP server <" .. config.key) .. ">: required executable '") .. config.required_executable) .. "' is not present.", vim.log.levels.WARN)
                            goto __continue29
                        end
                    end
                    local capabilities = vim.lsp.protocol.make_client_capabilities()
                    local ____opt_2 = getGlobalConfiguration().packages.cmp
                    if ____opt_2 and ____opt_2.enabled then
                        local cmp_capabilities = useExternalModule("cmp_nvim_lsp").default_capabilities()
                        capabilities = __TS__ObjectAssign({}, capabilities, cmp_capabilities)
                    end
                    local ____config_additionalOptions_4 = config.additionalOptions
                    if ____config_additionalOptions_4 == nil then
                        ____config_additionalOptions_4 = {}
                    end
                    local setupConfig = __TS__ObjectAssign({}, ____config_additionalOptions_4, {capabilities = capabilities, on_attach = on_attach})
                    for ____, preHook in ipairs(preHooks) do
                        preHook(config.lspKey, setupConfig)
                    end
                    lspconfig[config.lspKey].setup(setupConfig)
                end
            end
            ::__continue29::
        end
        vim.diagnostic.config({update_in_insert = true, virtual_lines = true})
    end)
end
local plugin = {[1] = "neovim/nvim-lspconfig", config = configureLSP}
attachCallbacks = {}
preHooks = {}
function ____exports.registerLSPServerAttachCallback(callback)
    attachCallbacks[#attachCallbacks + 1] = callback
    configureLSP()
end
function ____exports.registerLSPConfigurationHook(hook)
    preHooks[#preHooks + 1] = hook
    configureLSP()
end
do
    local lspConfig = getConfig()
    if lspConfig.inlayHints.enabled then
        if lspConfig.inlayHints.displayMode ~= "always" then
            vim.api.nvim_create_autocmd(
                "InsertEnter",
                {callback = function()
                    if lspConfig.inlayHints.displayMode == "only-in-normal-mode" then
                        vim.lsp.inlay_hint.enable(false)
                    end
                end}
            )
        end
        vim.api.nvim_create_autocmd(
            "InsertLeave",
            {callback = function()
                if lspConfig.inlayHints.displayMode == "only-in-normal-mode" or lspConfig.inlayHints.displayMode == "always" then
                    vim.lsp.inlay_hint.enable(true)
                end
            end}
        )
    end
end
local function getPluginConfig()
    local config = getGlobalConfiguration()
    return config.packages.lspconfig
end
vim.api.nvim_create_autocmd(
    "LspAttach",
    {callback = function(_args)
        local args = _args
    end}
)
____exports.default = plugin
return ____exports
 end,
["lua.plugins.lualine"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____configuration = require("lua.helpers.configuration.index")
local getGlobalConfiguration = ____configuration.getGlobalConfiguration
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local ____theme = require("lua.theme")
local globalThemeType = ____theme.globalThemeType
local onThemeChange = ____theme.onThemeChange
local ____navic = require("lua.plugins.navic")
local getNavic = ____navic.getNavic
local plugin = {
    [1] = "nvim-lualine/lualine.nvim",
    dependencies = {"nvim-tree/nvim-web-devicons"},
    config = function()
        local module = useExternalModule("lualine")
        local function createStandardComponent(____type)
            local result = {}
            result[1] = ____type
            return ____type
        end
        local function createCustomComponent(func, fmt)
            local result = {}
            result.fmt = fmt or (function(input) return input end)
            result[1] = func
            return result
        end
        local function genConfig()
            local config = {
                options = {
                    theme = globalThemeType() == "dark" and "material" or "ayu_light",
                    refresh = {}
                },
                sections = {
                    lualine_b = {
                        createStandardComponent("branch"),
                        createStandardComponent("diff"),
                        createStandardComponent("diagnostics")
                    },
                    lualine_c = {},
                    lualine_x = {}
                }
            }
            do
                local navic = getNavic()
                if navic ~= nil then
                    local ____config_sections_lualine_c_0 = config.sections.lualine_c
                    ____config_sections_lualine_c_0[#____config_sections_lualine_c_0 + 1] = createCustomComponent(function()
                        if navic.is_available() then
                            return navic.get_location()
                        else
                            return ""
                        end
                    end)
                end
            end
            local ____opt_1 = getGlobalConfiguration().packages.copilot
            if ____opt_1 and ____opt_1.enabled then
                local ____opt_3 = getGlobalConfiguration().packages.copilotLuaLine
                if ____opt_3 and ____opt_3.enabled then
                    local ____config_sections_lualine_x_5 = config.sections.lualine_x
                    ____config_sections_lualine_x_5[#____config_sections_lualine_x_5 + 1] = createStandardComponent("copilot")
                end
            end
            return config
        end
        onThemeChange(function(____type)
            module.setup(genConfig())
        end)
        module.setup(genConfig())
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.markdown-preview"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local plugin = {
    [1] = "iamcco/markdown-preview.nvim",
    cmd = {"MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop"},
    build = "cd app && npm install",
    init = function()
        vim.g.mkdp_filetypes = {"markdown"}
    end,
    ft = {"markdown"}
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.marks"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local plugin = {
    [1] = "chentoast/marks.nvim",
    config = function()
        local target = "marks"
        useExternalModule(target).setup()
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.markview"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local plugin = {[1] = "OXY2DEV/markview.nvim", lazy = false, dependencies = {"nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons"}}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.mason-nvim-dap"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
function ____exports.getMasonNvimDap()
    return useExternalModule("mason-nvim-dap")
end
local plugin = {
    [1] = "jay-babu/mason-nvim-dap.nvim",
    event = "InsertEnter",
    dependencies = {"williamboman/mason.nvim", "mfussenegger/nvim-dap"},
    config = function()
        ____exports.getMasonNvimDap().setup({ensure_installed = {
            "node2",
            "firefox",
            "cppdbg",
            "js",
            "codelldb"
        }})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.mason"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local plugin = {
    [1] = "williamboman/mason.nvim",
    config = function()
        useExternalModule("mason").setup()
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.midnight"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local plugin = {[1] = "dasupradyumna/midnight.nvim", lazy = false, priority = 1000}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.module-load-test"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local function test()
    vim.notify("LOADED PROPERLY", vim.log.levels.WARN)
end
____exports.test = test
return ____exports
 end,
["lua.plugins.neogen"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local plugin = {[1] = "danymat/neogen", config = true}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.neotest"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
function ____exports.useNeotest()
    return useExternalModule("neotest")
end
local plugin = {[1] = "nvim-neotest/neotest", dependencies = {"nvim-neotest/nvim-nio", "nvim-lua/plenary.nvim", "antoinemadec/FixCursorHold.nvim", "nvim-treesitter/nvim-treesitter"}}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.noice"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local function getNoice()
    local noice = useExternalModule("noice")
    return noice
end
local plugin = {
    [1] = "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {"MunifTanjim/nui.nvim", "rcarriga/nvim-notify"},
    config = function()
        if vim.g.started_by_firenvim then
        else
            local noice = getNoice()
            noice.setup({})
        end
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.nord"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local plugin = {[1] = "shaunsingh/nord.nvim", lazy = false, priority = 1000}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.nvim-notify"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local function getNvimNotify()
    local noice = useExternalModule("notify")
    return noice
end
local plugin = {
    [1] = "rcarriga/nvim-notify",
    event = "VeryLazy",
    dependencies = {"MunifTanjim/nui.nvim", "rcarriga/nvim-notify"},
    config = function()
        if vim.g.started_by_firenvim then
        else
            local notify = getNvimNotify()
            notify.setup({})
            vim.notify = notify
        end
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.nvim-tree-devicons"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local plugin = {
    [1] = "nvim-tree/nvim-web-devicons",
    config = function()
        local module = useExternalModule("nvim-web-devicons")
        module.setup()
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.nvim-tree"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local plugin = {
    [1] = "nvim-tree/nvim-tree.lua",
    cmd = {"NvimTreeToggle", "NvimTreeFocus"},
    opts = function()
        local options = {
            filters = {
                dotfiles = false,
                exclude = {vim.fn.stdpath("config") .. "/lua/custom"}
            },
            disable_netrw = true,
            hijack_netrw = true,
            hijack_cursor = true,
            hijack_unnamed_buffer_when_opening = false,
            sync_root_with_cwd = true,
            update_focused_file = {enable = true, update_root = false},
            view = {adaptive_size = false, side = "left", width = 30, preserve_window_proportions = true},
            git = {enable = false, ignore = true},
            filesystem_watchers = {enable = true},
            actions = {open_file = {resize_window = true}},
            renderer = {
                root_folder_label = false,
                highlight_git = false,
                highlight_opened_files = "none",
                indent_markers = {enable = false},
                icons = {show = {file = true, folder = true, folder_arrow = true, git = false}, glyphs = {default = "󰈚", symlink = "", folder = {
                    default = "",
                    empty = "",
                    empty_open = "",
                    open = "",
                    symlink = "",
                    symlink_open = "",
                    arrow_open = "",
                    arrow_closed = ""
                }, git = {
                    unstaged = "✗",
                    staged = "✓",
                    unmerged = "",
                    renamed = "➜",
                    untracked = "★",
                    deleted = "",
                    ignored = "◌"
                }}}
            }
        }
        return options
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.obsidian"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____configuration = require("lua.helpers.configuration.index")
local getGlobalConfiguration = ____configuration.getGlobalConfiguration
local ____temp_4 = {"markdown"}
local ____temp_5 = {"nvim-lua/plenary.nvim"}
local ____opt_2 = getGlobalConfiguration().packages.obsidian
local ____opt_0 = ____opt_2 and ____opt_2.config
local plugin = {
    [1] = "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = ____temp_4,
    dependencies = ____temp_5,
    opts = {workspaces = ____opt_0 and ____opt_0.workspaces or ({})}
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.octo"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local plugin = {
    event = "VeryLazy",
    cmd = {"Octo"},
    [1] = "pwntester/octo.nvim",
    dependencies = {"nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim", "nvim-tree/nvim-web-devicons"},
    config = function()
        useExternalModule("octo").setup()
        vim.treesitter.language.register("markdown", "octo")
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.outline"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local plugin = {
    [1] = "hedyhli/outline.nvim",
    lazy = true,
    cmd = {"Outline", "OutlineOpen"},
    keys = {{[1] = "<leader>o", [2] = "<cmd>Outline<CR>", desc = "Toggle outline"}},
    opts = {symbol_folding = {}, preview_window = {auto_preview = true, live = true}, outline_items = {show_symbol_lineno = true}}
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.overseer"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local function useOverseer()
    return useExternalModule("overseer")
end
local plugin = {
    [1] = "stevearc/overseer.nvim",
    opts = {},
    config = function()
        useOverseer().setup()
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.poimandres"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local plugin = {
    [1] = "olivercederborg/poimandres.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        useExternalModule("poimandres").setup({})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.presence"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local function usePresence()
    return useExternalModule("presence")
end
local plugin = {
    [1] = "andweeb/presence.nvim",
    config = function()
        usePresence().setup({})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.rainbow-delimiters"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local plugin = {
    [1] = "HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
    config = function()
        useExternalModule("rainbow-delimiters.setup").setup({})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.rest"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local plugin = {[1] = "rest-nvim/rest.nvim"}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.rustaceanvim"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
function ____exports.getRustaceonVimExtendedVIMApi()
    return vim
end
local plugin = {
    [1] = "mrcjkb/rustaceanvim",
    version = "^5",
    ft = {"rust"},
    dependencies = {"nvim-lua/plenary.nvim", "mfussenegger/nvim-dap"},
    config = function()
        local vim = ____exports.getRustaceonVimExtendedVIMApi()
        vim.g.rustaceanvim = {tools = {hover_actions = {auto_focus = false, replace_builtin_hover = false}}}
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.screenkey"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local plugin = {[1] = "NStefan002/screenkey.nvim", lazy = false, version = "*"}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.surround"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local plugin = {
    [1] = "kylechui/nvim-surround",
    version = "*",
    event = {"VeryLazy", "InsertEnter"},
    config = function()
        useExternalModule("nvim-surround").setup({})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.symbol-usage"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local function textFormat(symbol)
    local result = {}
    local roundStart = {"", "SymbolUsageRounding"}
    local roundEnd = {"", "SymbolUsageRounding"}
    local stackedFunctionsContent = symbol.stacked_count > 0 and tostring(symbol.stacked_count) or ""
    if symbol.references ~= nil then
        local usage = symbol.references <= 1 and "reference" or "references"
        local num = symbol.references == 0 and "no" or symbol.references
        result[#result + 1] = roundStart
        result[#result + 1] = {"󰌹 ", "SymbolUsageRef"}
        result[#result + 1] = {
            (tostring(num) .. " ") .. usage,
            "SymbolUsageContent"
        }
        result[#result + 1] = roundEnd
    end
    if symbol.definition then
        if #result > 0 then
            result[#result + 1] = {" ", "NonText"}
        end
        result[#result + 1] = roundStart
        result[#result + 1] = {"󰳽 ", "SymbolUsageDef"}
        result[#result + 1] = {
            tostring(symbol.definition) .. " defs",
            "SymbolUsageContent"
        }
        result[#result + 1] = roundEnd
    end
    if symbol.implementation then
        if #result > 0 then
            result[#result + 1] = {" ", "NonText"}
        end
        result[#result + 1] = roundStart
        result[#result + 1] = {"󰡱 ", "SymbolUsageImpl"}
        result[#result + 1] = {
            tostring(symbol.implementation) .. " impls",
            "SymbolUsageContent"
        }
        result[#result + 1] = roundEnd
    end
    if #stackedFunctionsContent > 0 then
        if #result > 0 then
            result[#result + 1] = {" ", "NonText"}
        end
        result[#result + 1] = roundStart
        result[#result + 1] = {" ", "SymbolUsageImpl"}
        result[#result + 1] = {stackedFunctionsContent, "SymbolUsageContent"}
        result[#result + 1] = roundEnd
    end
    return result
end
local plugin = {
    [1] = "Wansmer/symbol-usage.nvim",
    event = "LspAttach",
    config = function()
        useExternalModule("symbol-usage").setup({text_format = textFormat})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.telescope-import"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local plugin = {[1] = "piersolenski/telescope-import.nvim", dependencies = {"nvim-telescope/telescope.nvim"}}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.telescope"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
function ____exports.getTelescope()
    return useExternalModule("telescope")
end
local plugin = {
    [1] = "nvim-telescope/telescope.nvim",
    dependencies = {"nvim-lua/plenary.nvim"},
    config = function()
        ____exports.getTelescope().setup({extensions = {["ui-select"] = {useExternalModule("telescope.themes").get_dropdown({})}}})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.telescope-ui-select"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____telescope = require("lua.plugins.telescope")
local getTelescope = ____telescope.getTelescope
local plugin = {
    [1] = "nvim-telescope/telescope-ui-select.nvim",
    event = "VimEnter",
    config = function()
        getTelescope().load_extension("ui-select")
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.theme-flow"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local plugin = {
    [1] = "0xstepit/flow.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
        useExternalModule("flow").setup({
            dark_theme = true,
            high_contrast = false,
            transparent = true,
            fluo_color = "pink",
            mode = "base",
            aggressive_spell = false
        })
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.time-tracker"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local plugin = {
    [1] = "3rd/time-tracker.nvim",
    dependencies = {"3rd/sqlite.nvim"},
    event = "VeryLazy",
    cmd = {"TimeTracker"},
    config = function()
        useExternalModule("time-tracker").setup({
            data_file = vim.fn.stdpath("data") .. "/time-tracker.db",
            tracking_events = {
                "BufEnter",
                "BufWinEnter",
                "CursorMoved",
                "CursorMovedI",
                "WinScrolled"
            },
            tracking_timeout_seconds = 5 * 1000
        })
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.timerly"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local plugin = {[1] = "nvzone/timerly", dependencies = {"nvzone/volt"}}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.tiny-inline-diagnostic"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local function useTinyInlineDiagnostic()
    return useExternalModule("tiny-inline-diagnostic")
end
local plugin = {
    [1] = "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    config = function()
        useTinyInlineDiagnostic().setup({options = {multilines = true}})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.todo-comments"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local plugin = {[1] = "folke/todo-comments.nvim", dependencies = {"nvim-lua/plenary.nvim"}, opts = {}}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.tokyonight"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local plugin = {[1] = "folke/tokyonight.nvim", lazy = false, priority = 1000, opts = {}}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.treesitter-context"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local function useTreeSitterContextPlugin()
    return useExternalModule("treesitter-context")
end
local plugin = {
    [1] = "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    config = function()
        useTreeSitterContextPlugin().setup({enabled = true, max_lines = 2, trim_scope = "inner"})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.treesitter"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____configuration = require("lua.helpers.configuration.index")
local getGlobalConfiguration = ____configuration.getGlobalConfiguration
local ____getGlobalConfiguration_result_packages_tsAutoTag_enabled_2
local ____opt_0 = getGlobalConfiguration().packages.tsAutoTag
if ____opt_0 and ____opt_0.enabled then
    ____getGlobalConfiguration_result_packages_tsAutoTag_enabled_2 = true
else
    ____getGlobalConfiguration_result_packages_tsAutoTag_enabled_2 = nil
end
local plugin = {[1] = "nvim-treesitter/nvim-treesitter", opts = {autotag = {enable = ____getGlobalConfiguration_result_packages_tsAutoTag_enabled_2}}}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.treesj"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____keymap = require("lua.helpers.keymap.index")
local applyKeyMapping = ____keymap.applyKeyMapping
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local function getTreesj()
    return useExternalModule("treesj")
end
local plugin = {
    [1] = "Wansmer/treesj",
    keys = {"<space>j"},
    dependencies = {"nvim-treesitter/nvim-treesitter"},
    config = function()
        applyKeyMapping({
            mode = "n",
            inputStroke = "<leader>j",
            action = function()
                getTreesj().toggle()
            end,
            options = {}
        })
        return getTreesj().setup({use_default_keymaps = false, max_join_length = 4096})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.trouble"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local plugin = {[1] = "folke/trouble.nvim", cmd = {"Trouble"}, opts = {}}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.ts-autotag"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local plugin = {
    [1] = "windwp/nvim-ts-autotag",
    event = "VimEnter",
    config = function()
        useExternalModule("nvim-ts-autotag").setup({})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.ufo"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local ____lspconfig = require("lua.plugins.lspconfig")
local registerLSPConfigurationHook = ____lspconfig.registerLSPConfigurationHook
local plugin = {
    [1] = "kevinhwang91/nvim-ufo",
    dependencies = {"kevinhwang91/promise-async"},
    event = "VeryLazy",
    config = function()
        vim.o.foldcolumn = "0"
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.foldingRange = {dynamicRegistration = false, lineFoldingOnly = true}
        registerLSPConfigurationHook(function(key, config)
            config.capabilities.textDocument.foldingRange = {dynamicRegistration = false, lineFoldingOnly = true}
        end)
        useExternalModule("ufo").setup({})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.ultimate-autopair"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local plugin = {[1] = "altermo/ultimate-autopair.nvim", event = {"InsertEnter", "CmdlineEnter"}, opts = {bs = {space = "balance"}, cr = {autoclose = true}}}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.undotree"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local function getUndoTree()
    return useExternalModule("undotree")
end
local plugin = {
    [1] = "jiaoshijie/undotree",
    config = function()
        getUndoTree().setup()
        vim.api.nvim_create_user_command(
            "UndoTreeToggle",
            function()
                getUndoTree().toggle()
            end,
            {}
        )
        vim.api.nvim_create_user_command(
            "UndoTreeOpen",
            function()
                getUndoTree().open()
            end,
            {}
        )
        vim.api.nvim_create_user_command(
            "UndoTreeClose",
            function()
                getUndoTree().close()
            end,
            {}
        )
    end,
    dependencies = {"nvim-lua/plenary.nvim"}
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.wakatime"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local plugin = {[1] = "wakatime/vim-wakatime", lazy = false}
____exports.default = plugin
return ____exports
 end,
}
local __TS__SourceMapTraceBack = require("lualib_bundle").__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["2761"] = {line = 2, file = "useModule.ts"},["2764"] = {line = 7, file = "useModule.ts"},["2765"] = {line = 8, file = "useModule.ts"},["2768"] = {line = 4, file = "useModule.ts"},["2774"] = {line = 3, file = "useModule.ts"},["2777"] = {line = 2, file = "useModule.ts"},["2784"] = {line = 2, file = "nui.ts"},["2785"] = {line = 2, file = "nui.ts"},["2786"] = {line = 248, file = "nui.ts"},["2787"] = {line = 249, file = "nui.ts"},["2788"] = {line = 250, file = "nui.ts"},["2789"] = {line = 251, file = "nui.ts"},["2790"] = {line = 252, file = "nui.ts"},["2791"] = {line = 253, file = "nui.ts"},["2792"] = {line = 254, file = "nui.ts"},["2793"] = {line = 255, file = "nui.ts"},["2794"] = {line = 256, file = "nui.ts"},["2795"] = {line = 257, file = "nui.ts"},["2796"] = {line = 258, file = "nui.ts"},["2797"] = {line = 259, file = "nui.ts"},["2798"] = {line = 249, file = "nui.ts"},["2799"] = {line = 248, file = "nui.ts"},["2800"] = {line = 268, file = "nui.ts"},["2801"] = {line = 271, file = "nui.ts"},["2811"] = {line = 1, file = "index.ts"},["2812"] = {line = 1, file = "index.ts"},["2813"] = {line = 3, file = "index.ts"},["2814"] = {line = 11, file = "index.ts"},["2815"] = {line = 14, file = "index.ts"},["2816"] = {line = 14, file = "index.ts"},["2817"] = {line = 18, file = "index.ts"},["2818"] = {line = 19, file = "index.ts"},["2819"] = {line = 20, file = "index.ts"},["2820"] = {line = 18, file = "index.ts"},["2821"] = {line = 14, file = "index.ts"},["2822"] = {line = 23, file = "index.ts"},["2823"] = {line = 24, file = "index.ts"},["2825"] = {line = 27, file = "index.ts"},["2826"] = {line = 28, file = "index.ts"},["2827"] = {line = 28, file = "index.ts"},["2828"] = {line = 40, file = "index.ts"},["2829"] = {line = 41, file = "index.ts"},["2830"] = {line = 41, file = "index.ts"},["2831"] = {line = 41, file = "index.ts"},["2832"] = {line = 41, file = "index.ts"},["2833"] = {line = 42, file = "index.ts"},["2834"] = {line = 43, file = "index.ts"},["2835"] = {line = 44, file = "index.ts"},["2836"] = {line = 45, file = "index.ts"},["2837"] = {line = 42, file = "index.ts"},["2838"] = {line = 40, file = "index.ts"},["2839"] = {line = 28, file = "index.ts"},["2840"] = {line = 48, file = "index.ts"},["2841"] = {line = 49, file = "index.ts"},["2842"] = {line = 11, file = "index.ts"},["2843"] = {line = 52, file = "index.ts"},["2844"] = {line = 53, file = "index.ts"},["2845"] = {line = 52, file = "index.ts"},["2861"] = {line = 1, file = "index.ts"},["2862"] = {line = 2, file = "index.ts"},["2863"] = {line = 3, file = "index.ts"},["2864"] = {line = 3, file = "index.ts"},["2865"] = {line = 3, file = "index.ts"},["2866"] = {line = 3, file = "index.ts"},["2867"] = {line = 3, file = "index.ts"},["2868"] = {line = 3, file = "index.ts"},["2869"] = {line = 3, file = "index.ts"},["2870"] = {line = 3, file = "index.ts"},["2871"] = {line = 3, file = "index.ts"},["2872"] = {line = 3, file = "index.ts"},["2873"] = {line = 4, file = "index.ts"},["2874"] = {line = 5, file = "index.ts"},["2875"] = {line = 5, file = "index.ts"},["2876"] = {line = 5, file = "index.ts"},["2877"] = {line = 6, file = "index.ts"},["2878"] = {line = 7, file = "index.ts"},["2879"] = {line = 7, file = "index.ts"},["2880"] = {line = 7, file = "index.ts"},["2881"] = {line = 7, file = "index.ts"},["2882"] = {line = 8, file = "index.ts"},["2883"] = {line = 9, file = "index.ts"},["2884"] = {line = 9, file = "index.ts"},["2885"] = {line = 9, file = "index.ts"},["2886"] = {line = 9, file = "index.ts"},["2887"] = {line = 10, file = "index.ts"},["2888"] = {line = 11, file = "index.ts"},["2889"] = {line = 12, file = "index.ts"},["2890"] = {line = 13, file = "index.ts"},["2891"] = {line = 14, file = "index.ts"},["2893"] = {line = 16, file = "index.ts"},["2895"] = {line = 18, file = "index.ts"},["2896"] = {line = 1, file = "index.ts"},["2914"] = {line = 1, file = "argparser.ts"},["2915"] = {line = 2, file = "argparser.ts"},["2916"] = {line = 3, file = "argparser.ts"},["2918"] = {line = 5, file = "argparser.ts"},["2919"] = {line = 5, file = "argparser.ts"},["2920"] = {line = 6, file = "argparser.ts"},["2921"] = {line = 8, file = "argparser.ts"},["2922"] = {line = 9, file = "argparser.ts"},["2923"] = {line = 10, file = "argparser.ts"},["2925"] = {line = 12, file = "argparser.ts"},["2927"] = {line = 14, file = "argparser.ts"},["2929"] = {line = 15, file = "argparser.ts"},["2932"] = {line = 16, file = "argparser.ts"},["2933"] = {line = 17, file = "argparser.ts"},["2934"] = {line = 18, file = "argparser.ts"},["2935"] = {line = 19, file = "argparser.ts"},["2936"] = {line = 21, file = "argparser.ts"},["2937"] = {line = 22, file = "argparser.ts"},["2938"] = {line = 23, file = "argparser.ts"},["2940"] = {line = 26, file = "argparser.ts"},["2942"] = {line = 27, file = "argparser.ts"},["2946"] = {line = 30, file = "argparser.ts"},["2947"] = {line = 31, file = "argparser.ts"},["2948"] = {line = 32, file = "argparser.ts"},["2950"] = {line = 34, file = "argparser.ts"},["2952"] = {line = 36, file = "argparser.ts"},["2954"] = {line = 5, file = "argparser.ts"},["2957"] = {line = 40, file = "argparser.ts"},["2958"] = {line = 41, file = "argparser.ts"},["2960"] = {line = 44, file = "argparser.ts"},["2961"] = {line = 1, file = "argparser.ts"},["2975"] = {line = 1, file = "index.ts"},["2976"] = {line = 2, file = "index.ts"},["2977"] = {line = 3, file = "index.ts"},["2979"] = {line = 4, file = "index.ts"},["2983"] = {line = 7, file = "index.ts"},["2984"] = {line = 9, file = "index.ts"},["2985"] = {line = 11, file = "index.ts"},["2987"] = {line = 12, file = "index.ts"},["2991"] = {line = 15, file = "index.ts"},["2992"] = {line = 1, file = "index.ts"},["2993"] = {line = 18, file = "index.ts"},["2994"] = {line = 19, file = "index.ts"},["2995"] = {line = 20, file = "index.ts"},["2997"] = {line = 21, file = "index.ts"},["3001"] = {line = 23, file = "index.ts"},["3002"] = {line = 24, file = "index.ts"},["3003"] = {line = 18, file = "index.ts"},["3004"] = {line = 27, file = "index.ts"},["3005"] = {line = 28, file = "index.ts"},["3006"] = {line = 29, file = "index.ts"},["3007"] = {line = 30, file = "index.ts"},["3009"] = {line = 31, file = "index.ts"},["3013"] = {line = 33, file = "index.ts"},["3014"] = {line = 34, file = "index.ts"},["3015"] = {line = 35, file = "index.ts"},["3018"] = {line = 36, file = "index.ts"},["3020"] = {line = 38, file = "index.ts"},["3021"] = {line = 27, file = "index.ts"},["3022"] = {line = 41, file = "index.ts"},["3023"] = {line = 42, file = "index.ts"},["3024"] = {line = 43, file = "index.ts"},["3025"] = {line = 44, file = "index.ts"},["3026"] = {line = 45, file = "index.ts"},["3028"] = {line = 48, file = "index.ts"},["3030"] = {line = 41, file = "index.ts"},["3031"] = {line = 52, file = "index.ts"},["3041"] = {line = 1, file = "index.ts"},["3042"] = {line = 1, file = "index.ts"},["3043"] = {line = 2, file = "index.ts"},["3044"] = {line = 2, file = "index.ts"},["3045"] = {line = 3, file = "index.ts"},["3046"] = {line = 3, file = "index.ts"},["3047"] = {line = 5, file = "index.ts"},["3048"] = {line = 6, file = "index.ts"},["3049"] = {line = 7, file = "index.ts"},["3050"] = {line = 8, file = "index.ts"},["3052"] = {line = 9, file = "index.ts"},["3053"] = {line = 10, file = "index.ts"},["3054"] = {line = 11, file = "index.ts"},["3055"] = {line = 12, file = "index.ts"},["3058"] = {line = 15, file = "index.ts"},["3062"] = {line = 5, file = "index.ts"},["3063"] = {line = 19, file = "index.ts"},["3064"] = {line = 21, file = "index.ts"},["3065"] = {line = 21, file = "index.ts"},["3066"] = {line = 21, file = "index.ts"},["3067"] = {line = 23, file = "index.ts"},["3068"] = {line = 22, file = "index.ts"},["3069"] = {line = 21, file = "index.ts"},["3070"] = {line = 27, file = "index.ts"},["3071"] = {line = 28, file = "index.ts"},["3072"] = {line = 29, file = "index.ts"},["3074"] = {line = 31, file = "index.ts"},["3075"] = {line = 32, file = "index.ts"},["3076"] = {line = 33, file = "index.ts"},["3077"] = {line = 34, file = "index.ts"},["3078"] = {line = 34, file = "index.ts"},["3079"] = {line = 35, file = "index.ts"},["3080"] = {line = 36, file = "index.ts"},["3082"] = {line = 37, file = "index.ts"},["3083"] = {line = 38, file = "index.ts"},["3084"] = {line = 39, file = "index.ts"},["3086"] = {line = 42, file = "index.ts"},["3087"] = {line = 43, file = "index.ts"},["3088"] = {line = 43, file = "index.ts"},["3090"] = {line = 44, file = "index.ts"},["3091"] = {line = 44, file = "index.ts"},["3095"] = {line = 48, file = "index.ts"},["3096"] = {line = 49, file = "index.ts"},["3100"] = {line = 46, file = "index.ts"},["3110"] = {line = 34, file = "index.ts"},["3111"] = {line = 55, file = "index.ts"},["3112"] = {line = 57, file = "index.ts"},["3113"] = {line = 58, file = "index.ts"},["3114"] = {line = 27, file = "index.ts"},["3115"] = {line = 61, file = "index.ts"},["3116"] = {line = 62, file = "index.ts"},["3117"] = {line = 63, file = "index.ts"},["3118"] = {line = 63, file = "index.ts"},["3119"] = {line = 63, file = "index.ts"},["3120"] = {line = 64, file = "index.ts"},["3121"] = {line = 65, file = "index.ts"},["3122"] = {line = 66, file = "index.ts"},["3123"] = {line = 66, file = "index.ts"},["3124"] = {line = 66, file = "index.ts"},["3125"] = {line = 66, file = "index.ts"},["3126"] = {line = 66, file = "index.ts"},["3127"] = {line = 65, file = "index.ts"},["3128"] = {line = 63, file = "index.ts"},["3129"] = {line = 68, file = "index.ts"},["3130"] = {line = 69, file = "index.ts"},["3133"] = {line = 72, file = "index.ts"},["3134"] = {line = 72, file = "index.ts"},["3135"] = {line = 72, file = "index.ts"},["3136"] = {line = 73, file = "index.ts"},["3137"] = {line = 73, file = "index.ts"},["3138"] = {line = 73, file = "index.ts"},["3139"] = {line = 73, file = "index.ts"},["3140"] = {line = 73, file = "index.ts"},["3141"] = {line = 74, file = "index.ts"},["3142"] = {line = 75, file = "index.ts"},["3143"] = {line = 74, file = "index.ts"},["3144"] = {line = 72, file = "index.ts"},["3145"] = {line = 77, file = "index.ts"},["3146"] = {line = 78, file = "index.ts"},["3149"] = {line = 81, file = "index.ts"},["3150"] = {line = 77, file = "index.ts"},["3151"] = {line = 72, file = "index.ts"},["3152"] = {line = 68, file = "index.ts"},["3153"] = {line = 63, file = "index.ts"},["3154"] = {line = 61, file = "index.ts"},["3155"] = {line = 86, file = "index.ts"},["3156"] = {line = 87, file = "index.ts"},["3157"] = {line = 87, file = "index.ts"},["3158"] = {line = 87, file = "index.ts"},["3159"] = {line = 88, file = "index.ts"},["3160"] = {line = 96, file = "index.ts"},["3161"] = {line = 97, file = "index.ts"},["3164"] = {line = 100, file = "index.ts"},["3165"] = {line = 101, file = "index.ts"},["3166"] = {line = 102, file = "index.ts"},["3167"] = {line = 103, file = "index.ts"},["3169"] = {line = 105, file = "index.ts"},["3170"] = {line = 106, file = "index.ts"},["3171"] = {line = 107, file = "index.ts"},["3172"] = {line = 108, file = "index.ts"},["3173"] = {line = 109, file = "index.ts"},["3176"] = {line = 112, file = "index.ts"},["3177"] = {line = 113, file = "index.ts"},["3178"] = {line = 114, file = "index.ts"},["3180"] = {line = 117, file = "index.ts"},["3181"] = {line = 118, file = "index.ts"},["3182"] = {line = 118, file = "index.ts"},["3183"] = {line = 118, file = "index.ts"},["3184"] = {line = 118, file = "index.ts"},["3185"] = {line = 118, file = "index.ts"},["3186"] = {line = 118, file = "index.ts"},["3187"] = {line = 118, file = "index.ts"},["3189"] = {line = 87, file = "index.ts"},["3190"] = {line = 120, file = "index.ts"},["3191"] = {line = 87, file = "index.ts"},["3192"] = {line = 86, file = "index.ts"},["3210"] = {line = 1, file = "index.ts"},["3211"] = {line = 1, file = "index.ts"},["3212"] = {line = 3, file = "index.ts"},["3213"] = {line = 6, file = "index.ts"},["3214"] = {line = 3, file = "index.ts"},["3215"] = {line = 9, file = "index.ts"},["3216"] = {line = 10, file = "index.ts"},["3217"] = {line = 11, file = "index.ts"},["3218"] = {line = 12, file = "index.ts"},["3219"] = {line = 16, file = "index.ts"},["3220"] = {line = 17, file = "index.ts"},["3221"] = {line = 18, file = "index.ts"},["3222"] = {line = 19, file = "index.ts"},["3223"] = {line = 20, file = "index.ts"},["3224"] = {line = 21, file = "index.ts"},["3225"] = {line = 22, file = "index.ts"},["3226"] = {line = 22, file = "index.ts"},["3227"] = {line = 22, file = "index.ts"},["3228"] = {line = 22, file = "index.ts"},["3229"] = {line = 21, file = "index.ts"},["3230"] = {line = 17, file = "index.ts"},["3231"] = {line = 25, file = "index.ts"},["3232"] = {line = 26, file = "index.ts"},["3233"] = {line = 27, file = "index.ts"},["3234"] = {line = 28, file = "index.ts"},["3235"] = {line = 29, file = "index.ts"},["3236"] = {line = 30, file = "index.ts"},["3237"] = {line = 31, file = "index.ts"},["3238"] = {line = 32, file = "index.ts"},["3240"] = {line = 34, file = "index.ts"},["3241"] = {line = 29, file = "index.ts"},["3242"] = {line = 36, file = "index.ts"},["3243"] = {line = 37, file = "index.ts"},["3244"] = {line = 37, file = "index.ts"},["3245"] = {line = 37, file = "index.ts"},["3246"] = {line = 37, file = "index.ts"},["3247"] = {line = 36, file = "index.ts"},["3248"] = {line = 25, file = "index.ts"},["3249"] = {line = 16, file = "index.ts"},["3250"] = {line = 41, file = "index.ts"},["3251"] = {line = 42, file = "index.ts"},["3252"] = {line = 43, file = "index.ts"},["3253"] = {line = 44, file = "index.ts"},["3254"] = {line = 45, file = "index.ts"},["3255"] = {line = 46, file = "index.ts"},["3256"] = {line = 47, file = "index.ts"},["3258"] = {line = 49, file = "index.ts"},["3259"] = {line = 50, file = "index.ts"},["3260"] = {line = 43, file = "index.ts"},["3261"] = {line = 52, file = "index.ts"},["3263"] = {line = 53, file = "index.ts"},["3264"] = {line = 54, file = "index.ts"},["3265"] = {line = 55, file = "index.ts"},["3267"] = {line = 57, file = "index.ts"},["3271"] = {line = 62, file = "index.ts"},["3272"] = {line = 41, file = "index.ts"},["3273"] = {line = 64, file = "index.ts"},["3274"] = {line = 69, file = "index.ts"},["3275"] = {line = 70, file = "index.ts"},["3276"] = {line = 72, file = "index.ts"},["3277"] = {line = 73, file = "index.ts"},["3278"] = {line = 72, file = "index.ts"},["3279"] = {line = 76, file = "index.ts"},["3280"] = {line = 76, file = "index.ts"},["3281"] = {line = 76, file = "index.ts"},["3282"] = {line = 76, file = "index.ts"},["3283"] = {line = 77, file = "index.ts"},["3284"] = {line = 76, file = "index.ts"},["3285"] = {line = 76, file = "index.ts"},["3286"] = {line = 80, file = "index.ts"},["3287"] = {line = 81, file = "index.ts"},["3288"] = {line = 82, file = "index.ts"},["3289"] = {line = 83, file = "index.ts"},["3290"] = {line = 84, file = "index.ts"},["3291"] = {line = 87, file = "index.ts"},["3292"] = {line = 87, file = "index.ts"},["3293"] = {line = 87, file = "index.ts"},["3294"] = {line = 87, file = "index.ts"},["3295"] = {line = 88, file = "index.ts"},["3296"] = {line = 89, file = "index.ts"},["3297"] = {line = 90, file = "index.ts"},["3300"] = {line = 93, file = "index.ts"},["3304"] = {line = 95, file = "index.ts"},["3306"] = {line = 102, file = "index.ts"},["3309"] = {line = 106, file = "index.ts"},["3311"] = {line = 80, file = "index.ts"},["3312"] = {line = 110, file = "index.ts"},["3313"] = {line = 110, file = "index.ts"},["3314"] = {line = 110, file = "index.ts"},["3315"] = {line = 110, file = "index.ts"},["3316"] = {line = 111, file = "index.ts"},["3317"] = {line = 112, file = "index.ts"},["3318"] = {line = 113, file = "index.ts"},["3319"] = {line = 114, file = "index.ts"},["3320"] = {line = 117, file = "index.ts"},["3321"] = {line = 118, file = "index.ts"},["3322"] = {line = 118, file = "index.ts"},["3323"] = {line = 118, file = "index.ts"},["3324"] = {line = 118, file = "index.ts"},["3325"] = {line = 119, file = "index.ts"},["3326"] = {line = 120, file = "index.ts"},["3327"] = {line = 121, file = "index.ts"},["3330"] = {line = 110, file = "index.ts"},["3331"] = {line = 110, file = "index.ts"},["3332"] = {line = 126, file = "index.ts"},["3333"] = {line = 126, file = "index.ts"},["3334"] = {line = 126, file = "index.ts"},["3335"] = {line = 126, file = "index.ts"},["3336"] = {line = 127, file = "index.ts"},["3337"] = {line = 128, file = "index.ts"},["3338"] = {line = 129, file = "index.ts"},["3339"] = {line = 130, file = "index.ts"},["3341"] = {line = 126, file = "index.ts"},["3342"] = {line = 126, file = "index.ts"},["3343"] = {line = 134, file = "index.ts"},["3344"] = {line = 134, file = "index.ts"},["3345"] = {line = 134, file = "index.ts"},["3346"] = {line = 134, file = "index.ts"},["3347"] = {line = 135, file = "index.ts"},["3348"] = {line = 136, file = "index.ts"},["3351"] = {line = 139, file = "index.ts"},["3352"] = {line = 140, file = "index.ts"},["3355"] = {line = 143, file = "index.ts"},["3356"] = {line = 143, file = "index.ts"},["3357"] = {line = 143, file = "index.ts"},["3358"] = {line = 143, file = "index.ts"},["3359"] = {line = 144, file = "index.ts"},["3362"] = {line = 147, file = "index.ts"},["3363"] = {line = 148, file = "index.ts"},["3364"] = {line = 151, file = "index.ts"},["3365"] = {line = 152, file = "index.ts"},["3366"] = {line = 134, file = "index.ts"},["3367"] = {line = 134, file = "index.ts"},["3368"] = {line = 155, file = "index.ts"},["3369"] = {line = 155, file = "index.ts"},["3370"] = {line = 155, file = "index.ts"},["3371"] = {line = 155, file = "index.ts"},["3372"] = {line = 156, file = "index.ts"},["3373"] = {line = 157, file = "index.ts"},["3374"] = {line = 158, file = "index.ts"},["3375"] = {line = 160, file = "index.ts"},["3376"] = {line = 161, file = "index.ts"},["3379"] = {line = 164, file = "index.ts"},["3380"] = {line = 164, file = "index.ts"},["3381"] = {line = 164, file = "index.ts"},["3382"] = {line = 164, file = "index.ts"},["3383"] = {line = 165, file = "index.ts"},["3386"] = {line = 168, file = "index.ts"},["3387"] = {line = 169, file = "index.ts"},["3388"] = {line = 170, file = "index.ts"},["3389"] = {line = 171, file = "index.ts"},["3390"] = {line = 172, file = "index.ts"},["3392"] = {line = 155, file = "index.ts"},["3393"] = {line = 155, file = "index.ts"},["3394"] = {line = 176, file = "index.ts"},["3395"] = {line = 176, file = "index.ts"},["3396"] = {line = 176, file = "index.ts"},["3397"] = {line = 176, file = "index.ts"},["3398"] = {line = 177, file = "index.ts"},["3399"] = {line = 178, file = "index.ts"},["3400"] = {line = 179, file = "index.ts"},["3401"] = {line = 179, file = "index.ts"},["3402"] = {line = 194, file = "index.ts"},["3403"] = {line = 195, file = "index.ts"},["3404"] = {line = 196, file = "index.ts"},["3405"] = {line = 197, file = "index.ts"},["3406"] = {line = 198, file = "index.ts"},["3407"] = {line = 199, file = "index.ts"},["3408"] = {line = 200, file = "index.ts"},["3409"] = {line = 197, file = "index.ts"},["3410"] = {line = 194, file = "index.ts"},["3411"] = {line = 179, file = "index.ts"},["3412"] = {line = 203, file = "index.ts"},["3413"] = {line = 204, file = "index.ts"},["3414"] = {line = 204, file = "index.ts"},["3415"] = {line = 204, file = "index.ts"},["3416"] = {line = 204, file = "index.ts"},["3417"] = {line = 205, file = "index.ts"},["3418"] = {line = 204, file = "index.ts"},["3419"] = {line = 204, file = "index.ts"},["3421"] = {line = 176, file = "index.ts"},["3422"] = {line = 176, file = "index.ts"},["3423"] = {line = 9, file = "index.ts"},["3424"] = {line = 217, file = "index.ts"},["3425"] = {line = 218, file = "index.ts"},["3426"] = {line = 218, file = "index.ts"},["3427"] = {line = 218, file = "index.ts"},["3428"] = {line = 219, file = "index.ts"},["3429"] = {line = 218, file = "index.ts"},["3430"] = {line = 220, file = "index.ts"},["3431"] = {line = 218, file = "index.ts"},["3432"] = {line = 217, file = "index.ts"},["3439"] = {line = 1, file = "index.ts"},["3440"] = {line = 2, file = "index.ts"},["3441"] = {line = 2, file = "index.ts"},["3442"] = {line = 2, file = "index.ts"},["3443"] = {line = 3, file = "index.ts"},["3444"] = {line = 2, file = "index.ts"},["3445"] = {line = 4, file = "index.ts"},["3446"] = {line = 2, file = "index.ts"},["3447"] = {line = 1, file = "index.ts"},["3455"] = {line = 23, file = "index.ts"},["3456"] = {line = 24, file = "index.ts"},["3457"] = {line = 25, file = "index.ts"},["3458"] = {line = 26, file = "index.ts"},["3460"] = {line = 29, file = "index.ts"},["3462"] = {line = 23, file = "index.ts"},["3463"] = {line = 33, file = "index.ts"},["3464"] = {line = 34, file = "index.ts"},["3465"] = {line = 35, file = "index.ts"},["3466"] = {line = 36, file = "index.ts"},["3468"] = {line = 39, file = "index.ts"},["3470"] = {line = 33, file = "index.ts"},["3477"] = {line = 1, file = "index.ts"},["3478"] = {line = 1, file = "index.ts"},["3479"] = {line = 3, file = "index.ts"},["3480"] = {line = 4, file = "index.ts"},["3481"] = {line = 5, file = "index.ts"},["3482"] = {line = 6, file = "index.ts"},["3483"] = {line = 7, file = "index.ts"},["3484"] = {line = 8, file = "index.ts"},["3485"] = {line = 8, file = "index.ts"},["3486"] = {line = 8, file = "index.ts"},["3487"] = {line = 9, file = "index.ts"},["3490"] = {line = 13, file = "index.ts"},["3491"] = {line = 14, file = "index.ts"},["3493"] = {line = 8, file = "index.ts"},["3494"] = {line = 8, file = "index.ts"},["3495"] = {line = 7, file = "index.ts"},["3496"] = {line = 18, file = "index.ts"},["3497"] = {line = 4, file = "index.ts"},["3498"] = {line = 3, file = "index.ts"},["3505"] = {line = 1, file = "index.ts"},["3506"] = {line = 2, file = "index.ts"},["3507"] = {line = 2, file = "index.ts"},["3508"] = {line = 2, file = "index.ts"},["3509"] = {line = 3, file = "index.ts"},["3510"] = {line = 2, file = "index.ts"},["3511"] = {line = 4, file = "index.ts"},["3512"] = {line = 2, file = "index.ts"},["3513"] = {line = 1, file = "index.ts"},["3520"] = {line = 1, file = "index.ts"},["3521"] = {line = 1, file = "index.ts"},["3522"] = {line = 2, file = "index.ts"},["3523"] = {line = 2, file = "index.ts"},["3524"] = {line = 4, file = "index.ts"},["3525"] = {line = 5, file = "index.ts"},["3526"] = {line = 5, file = "index.ts"},["3527"] = {line = 5, file = "index.ts"},["3528"] = {line = 6, file = "index.ts"},["3529"] = {line = 12, file = "index.ts"},["3530"] = {line = 17, file = "index.ts"},["3531"] = {line = 12, file = "index.ts"},["3532"] = {line = 20, file = "index.ts"},["3533"] = {line = 21, file = "index.ts"},["3534"] = {line = 23, file = "index.ts"},["3535"] = {line = 24, file = "index.ts"},["3537"] = {line = 5, file = "index.ts"},["3538"] = {line = 26, file = "index.ts"},["3539"] = {line = 5, file = "index.ts"},["3540"] = {line = 4, file = "index.ts"},["3547"] = {line = 1, file = "index.ts"},["3548"] = {line = 1, file = "index.ts"},["3549"] = {line = 3, file = "index.ts"},["3550"] = {line = 4, file = "index.ts"},["3551"] = {line = 3, file = "index.ts"},["3558"] = {line = 1, file = "theme.ts"},["3559"] = {line = 1, file = "theme.ts"},["3560"] = {line = 2, file = "theme.ts"},["3562"] = {line = 56, file = "theme.ts"},["3563"] = {line = 57, file = "theme.ts"},["3564"] = {line = 57, file = "theme.ts"},["3565"] = {line = 57, file = "theme.ts"},["3566"] = {line = 57, file = "theme.ts"},["3567"] = {line = 57, file = "theme.ts"},["3568"] = {line = 57, file = "theme.ts"},["3569"] = {line = 57, file = "theme.ts"},["3570"] = {line = 57, file = "theme.ts"},["3571"] = {line = 58, file = "theme.ts"},["3572"] = {line = 58, file = "theme.ts"},["3573"] = {line = 58, file = "theme.ts"},["3574"] = {line = 58, file = "theme.ts"},["3575"] = {line = 58, file = "theme.ts"},["3576"] = {line = 58, file = "theme.ts"},["3577"] = {line = 58, file = "theme.ts"},["3578"] = {line = 58, file = "theme.ts"},["3579"] = {line = 58, file = "theme.ts"},["3580"] = {line = 59, file = "theme.ts"},["3581"] = {line = 59, file = "theme.ts"},["3582"] = {line = 59, file = "theme.ts"},["3583"] = {line = 59, file = "theme.ts"},["3584"] = {line = 59, file = "theme.ts"},["3585"] = {line = 59, file = "theme.ts"},["3586"] = {line = 59, file = "theme.ts"},["3587"] = {line = 59, file = "theme.ts"},["3588"] = {line = 59, file = "theme.ts"},["3589"] = {line = 60, file = "theme.ts"},["3590"] = {line = 60, file = "theme.ts"},["3591"] = {line = 60, file = "theme.ts"},["3592"] = {line = 60, file = "theme.ts"},["3593"] = {line = 60, file = "theme.ts"},["3594"] = {line = 60, file = "theme.ts"},["3595"] = {line = 60, file = "theme.ts"},["3596"] = {line = 60, file = "theme.ts"},["3597"] = {line = 60, file = "theme.ts"},["3598"] = {line = 61, file = "theme.ts"},["3599"] = {line = 61, file = "theme.ts"},["3600"] = {line = 61, file = "theme.ts"},["3601"] = {line = 61, file = "theme.ts"},["3602"] = {line = 61, file = "theme.ts"},["3603"] = {line = 61, file = "theme.ts"},["3604"] = {line = 61, file = "theme.ts"},["3605"] = {line = 61, file = "theme.ts"},["3606"] = {line = 61, file = "theme.ts"},["3608"] = {line = 64, file = "theme.ts"},["3609"] = {line = 65, file = "theme.ts"},["3610"] = {line = 66, file = "theme.ts"},["3611"] = {line = 67, file = "theme.ts"},["3612"] = {line = 68, file = "theme.ts"},["3613"] = {line = 69, file = "theme.ts"},["3614"] = {line = 70, file = "theme.ts"},["3615"] = {line = 71, file = "theme.ts"},["3616"] = {line = 72, file = "theme.ts"},["3618"] = {line = 75, file = "theme.ts"},["3619"] = {line = 76, file = "theme.ts"},["3621"] = {line = 7, file = "theme.ts"},["3622"] = {line = 11, file = "theme.ts"},["3623"] = {line = 13, file = "theme.ts"},["3624"] = {line = 14, file = "theme.ts"},["3625"] = {line = 13, file = "theme.ts"},["3626"] = {line = 17, file = "theme.ts"},["3627"] = {line = 18, file = "theme.ts"},["3628"] = {line = 19, file = "theme.ts"},["3629"] = {line = 20, file = "theme.ts"},["3631"] = {line = 17, file = "theme.ts"},["3632"] = {line = 24, file = "theme.ts"},["3633"] = {line = 25, file = "theme.ts"},["3634"] = {line = 24, file = "theme.ts"},["3635"] = {line = 28, file = "theme.ts"},["3636"] = {line = 29, file = "theme.ts"},["3637"] = {line = 34, file = "theme.ts"},["3638"] = {line = 35, file = "theme.ts"},["3639"] = {line = 36, file = "theme.ts"},["3640"] = {line = 37, file = "theme.ts"},["3641"] = {line = 28, file = "theme.ts"},["3642"] = {line = 40, file = "theme.ts"},["3643"] = {line = 41, file = "theme.ts"},["3644"] = {line = 42, file = "theme.ts"},["3645"] = {line = 43, file = "theme.ts"},["3646"] = {line = 44, file = "theme.ts"},["3647"] = {line = 45, file = "theme.ts"},["3648"] = {line = 40, file = "theme.ts"},["3649"] = {line = 48, file = "theme.ts"},["3650"] = {line = 49, file = "theme.ts"},["3651"] = {line = 50, file = "theme.ts"},["3652"] = {line = 51, file = "theme.ts"},["3653"] = {line = 52, file = "theme.ts"},["3654"] = {line = 53, file = "theme.ts"},["3655"] = {line = 48, file = "theme.ts"},["3656"] = {line = 79, file = "theme.ts"},["3657"] = {line = 80, file = "theme.ts"},["3658"] = {line = 81, file = "theme.ts"},["3659"] = {line = 82, file = "theme.ts"},["3660"] = {line = 83, file = "theme.ts"},["3661"] = {line = 84, file = "theme.ts"},["3662"] = {line = 79, file = "theme.ts"},["3663"] = {line = 87, file = "theme.ts"},["3664"] = {line = 88, file = "theme.ts"},["3665"] = {line = 89, file = "theme.ts"},["3666"] = {line = 90, file = "theme.ts"},["3667"] = {line = 91, file = "theme.ts"},["3668"] = {line = 92, file = "theme.ts"},["3669"] = {line = 87, file = "theme.ts"},["3670"] = {line = 95, file = "theme.ts"},["3671"] = {line = 96, file = "theme.ts"},["3672"] = {line = 97, file = "theme.ts"},["3673"] = {line = 98, file = "theme.ts"},["3674"] = {line = 99, file = "theme.ts"},["3675"] = {line = 100, file = "theme.ts"},["3676"] = {line = 95, file = "theme.ts"},["3677"] = {line = 103, file = "theme.ts"},["3678"] = {line = 104, file = "theme.ts"},["3679"] = {line = 105, file = "theme.ts"},["3680"] = {line = 106, file = "theme.ts"},["3681"] = {line = 107, file = "theme.ts"},["3682"] = {line = 108, file = "theme.ts"},["3683"] = {line = 109, file = "theme.ts"},["3684"] = {line = 103, file = "theme.ts"},["3685"] = {line = 112, file = "theme.ts"},["3686"] = {line = 113, file = "theme.ts"},["3687"] = {line = 114, file = "theme.ts"},["3688"] = {line = 115, file = "theme.ts"},["3689"] = {line = 116, file = "theme.ts"},["3690"] = {line = 117, file = "theme.ts"},["3691"] = {line = 112, file = "theme.ts"},["3692"] = {line = 120, file = "theme.ts"},["3693"] = {line = 121, file = "theme.ts"},["3694"] = {line = 122, file = "theme.ts"},["3695"] = {line = 123, file = "theme.ts"},["3696"] = {line = 124, file = "theme.ts"},["3697"] = {line = 120, file = "theme.ts"},["3698"] = {line = 128, file = "theme.ts"},["3699"] = {line = 129, file = "theme.ts"},["3700"] = {line = 130, file = "theme.ts"},["3701"] = {line = 131, file = "theme.ts"},["3702"] = {line = 132, file = "theme.ts"},["3703"] = {line = 133, file = "theme.ts"},["3704"] = {line = 134, file = "theme.ts"},["3705"] = {line = 135, file = "theme.ts"},["3706"] = {line = 136, file = "theme.ts"},["3707"] = {line = 137, file = "theme.ts"},["3708"] = {line = 128, file = "theme.ts"},["3715"] = {line = 1, file = "index.ts"},["3716"] = {line = 1, file = "index.ts"},["3717"] = {line = 3, file = "index.ts"},["3718"] = {line = 7, file = "index.ts"},["3719"] = {line = 9, file = "index.ts"},["3720"] = {line = 11, file = "index.ts"},["3721"] = {line = 12, file = "index.ts"},["3722"] = {line = 11, file = "index.ts"},["3723"] = {line = 15, file = "index.ts"},["3725"] = {line = 17, file = "index.ts"},["3726"] = {line = 18, file = "index.ts"},["3727"] = {line = 19, file = "index.ts"},["3730"] = {line = 23, file = "index.ts"},["3731"] = {line = 25, file = "index.ts"},["3732"] = {line = 27, file = "index.ts"},["3733"] = {line = 28, file = "index.ts"},["3735"] = {line = 31, file = "index.ts"},["3736"] = {line = 32, file = "index.ts"},["3737"] = {line = 31, file = "index.ts"},["3738"] = {line = 35, file = "index.ts"},["3739"] = {line = 36, file = "index.ts"},["3740"] = {line = 37, file = "index.ts"},["3741"] = {line = 37, file = "index.ts"},["3742"] = {line = 37, file = "index.ts"},["3743"] = {line = 37, file = "index.ts"},["3744"] = {line = 38, file = "index.ts"},["3745"] = {line = 35, file = "index.ts"},["3746"] = {line = 41, file = "index.ts"},["3747"] = {line = 43, file = "index.ts"},["3748"] = {line = 45, file = "index.ts"},["3749"] = {line = 15, file = "index.ts"},["3769"] = {line = 13, file = "index.ts"},["3770"] = {line = 1, file = "index.ts"},["3771"] = {line = 1, file = "index.ts"},["3772"] = {line = 3, file = "index.ts"},["3773"] = {line = 3, file = "index.ts"},["3774"] = {line = 4, file = "index.ts"},["3775"] = {line = 4, file = "index.ts"},["3776"] = {line = 13, file = "index.ts"},["3777"] = {line = 14, file = "index.ts"},["3778"] = {line = 15, file = "index.ts"},["3779"] = {line = 17, file = "index.ts"},["3780"] = {line = 18, file = "index.ts"},["3781"] = {line = 19, file = "index.ts"},["3783"] = {line = 21, file = "index.ts"},["3786"] = {line = 25, file = "index.ts"},["3787"] = {line = 26, file = "index.ts"},["3789"] = {line = 379, file = "index.ts"},["3790"] = {line = 380, file = "index.ts"},["3791"] = {line = 381, file = "index.ts"},["3793"] = {line = 383, file = "index.ts"},["3794"] = {line = 379, file = "index.ts"},["3795"] = {line = 386, file = "index.ts"},["3796"] = {line = 387, file = "index.ts"},["3797"] = {line = 386, file = "index.ts"},["3798"] = {line = 6, file = "index.ts"},["3799"] = {line = 8, file = "index.ts"},["3800"] = {line = 57, file = "index.ts"},["3801"] = {line = 58, file = "index.ts"},["3802"] = {line = 61, file = "index.ts"},["3803"] = {line = 62, file = "index.ts"},["3804"] = {line = 65, file = "index.ts"},["3805"] = {line = 69, file = "index.ts"},["3806"] = {line = 72, file = "index.ts"},["3807"] = {line = 75, file = "index.ts"},["3808"] = {line = 78, file = "index.ts"},["3809"] = {line = 81, file = "index.ts"},["3810"] = {line = 84, file = "index.ts"},["3811"] = {line = 87, file = "index.ts"},["3812"] = {line = 90, file = "index.ts"},["3813"] = {line = 93, file = "index.ts"},["3814"] = {line = 96, file = "index.ts"},["3815"] = {line = 99, file = "index.ts"},["3816"] = {line = 102, file = "index.ts"},["3817"] = {line = 105, file = "index.ts"},["3818"] = {line = 108, file = "index.ts"},["3819"] = {line = 111, file = "index.ts"},["3820"] = {line = 114, file = "index.ts"},["3821"] = {line = 117, file = "index.ts"},["3822"] = {line = 120, file = "index.ts"},["3823"] = {line = 123, file = "index.ts"},["3824"] = {line = 126, file = "index.ts"},["3825"] = {line = 129, file = "index.ts"},["3826"] = {line = 137, file = "index.ts"},["3827"] = {line = 140, file = "index.ts"},["3828"] = {line = 143, file = "index.ts"},["3829"] = {line = 146, file = "index.ts"},["3830"] = {line = 149, file = "index.ts"},["3831"] = {line = 152, file = "index.ts"},["3832"] = {line = 155, file = "index.ts"},["3833"] = {line = 158, file = "index.ts"},["3834"] = {line = 161, file = "index.ts"},["3835"] = {line = 170, file = "index.ts"},["3836"] = {line = 173, file = "index.ts"},["3837"] = {line = 176, file = "index.ts"},["3838"] = {line = 187, file = "index.ts"},["3839"] = {line = 190, file = "index.ts"},["3840"] = {line = 193, file = "index.ts"},["3841"] = {line = 196, file = "index.ts"},["3842"] = {line = 199, file = "index.ts"},["3843"] = {line = 202, file = "index.ts"},["3844"] = {line = 206, file = "index.ts"},["3845"] = {line = 209, file = "index.ts"},["3846"] = {line = 212, file = "index.ts"},["3847"] = {line = 215, file = "index.ts"},["3848"] = {line = 218, file = "index.ts"},["3849"] = {line = 221, file = "index.ts"},["3850"] = {line = 224, file = "index.ts"},["3851"] = {line = 227, file = "index.ts"},["3852"] = {line = 230, file = "index.ts"},["3853"] = {line = 233, file = "index.ts"},["3854"] = {line = 236, file = "index.ts"},["3855"] = {line = 239, file = "index.ts"},["3856"] = {line = 242, file = "index.ts"},["3857"] = {line = 245, file = "index.ts"},["3858"] = {line = 248, file = "index.ts"},["3859"] = {line = 254, file = "index.ts"},["3860"] = {line = 257, file = "index.ts"},["3861"] = {line = 260, file = "index.ts"},["3862"] = {line = 263, file = "index.ts"},["3863"] = {line = 266, file = "index.ts"},["3864"] = {line = 269, file = "index.ts"},["3865"] = {line = 272, file = "index.ts"},["3866"] = {line = 275, file = "index.ts"},["3867"] = {line = 278, file = "index.ts"},["3868"] = {line = 281, file = "index.ts"},["3869"] = {line = 284, file = "index.ts"},["3870"] = {line = 287, file = "index.ts"},["3871"] = {line = 290, file = "index.ts"},["3872"] = {line = 293, file = "index.ts"},["3873"] = {line = 296, file = "index.ts"},["3874"] = {line = 299, file = "index.ts"},["3875"] = {line = 302, file = "index.ts"},["3876"] = {line = 305, file = "index.ts"},["3877"] = {line = 61, file = "index.ts"},["3878"] = {line = 309, file = "index.ts"},["3879"] = {line = 310, file = "index.ts"},["3880"] = {line = 313, file = "index.ts"},["3881"] = {line = 316, file = "index.ts"},["3882"] = {line = 319, file = "index.ts"},["3883"] = {line = 322, file = "index.ts"},["3884"] = {line = 325, file = "index.ts"},["3885"] = {line = 328, file = "index.ts"},["3886"] = {line = 331, file = "index.ts"},["3887"] = {line = 334, file = "index.ts"},["3888"] = {line = 337, file = "index.ts"},["3889"] = {line = 309, file = "index.ts"},["3890"] = {line = 341, file = "index.ts"},["3891"] = {line = 345, file = "index.ts"},["3892"] = {line = 57, file = "index.ts"},["3893"] = {line = 360, file = "index.ts"},["3894"] = {line = 362, file = "index.ts"},["3895"] = {line = 363, file = "index.ts"},["3896"] = {line = 367, file = "index.ts"},["3897"] = {line = 368, file = "index.ts"},["3898"] = {line = 369, file = "index.ts"},["3899"] = {line = 368, file = "index.ts"},["3900"] = {line = 371, file = "index.ts"},["3901"] = {line = 372, file = "index.ts"},["3902"] = {line = 373, file = "index.ts"},["3903"] = {line = 374, file = "index.ts"},["3905"] = {line = 376, file = "index.ts"},["3906"] = {line = 362, file = "index.ts"},["3907"] = {line = 390, file = "index.ts"},["3908"] = {line = 390, file = "index.ts"},["3909"] = {line = 390, file = "index.ts"},["3910"] = {line = 391, file = "index.ts"},["3911"] = {line = 408, file = "index.ts"},["3912"] = {line = 409, file = "index.ts"},["3913"] = {line = 410, file = "index.ts"},["3914"] = {line = 411, file = "index.ts"},["3915"] = {line = 410, file = "index.ts"},["3916"] = {line = 413, file = "index.ts"},["3917"] = {line = 414, file = "index.ts"},["3918"] = {line = 415, file = "index.ts"},["3919"] = {line = 416, file = "index.ts"},["3920"] = {line = 417, file = "index.ts"},["3921"] = {line = 418, file = "index.ts"},["3922"] = {line = 419, file = "index.ts"},["3924"] = {line = 421, file = "index.ts"},["3926"] = {line = 423, file = "index.ts"},["3928"] = {line = 425, file = "index.ts"},["3929"] = {line = 426, file = "index.ts"},["3930"] = {line = 426, file = "index.ts"},["3931"] = {line = 426, file = "index.ts"},["3932"] = {line = 426, file = "index.ts"},["3933"] = {line = 427, file = "index.ts"},["3935"] = {line = 429, file = "index.ts"},["3936"] = {line = 430, file = "index.ts"},["3937"] = {line = 431, file = "index.ts"},["3938"] = {line = 431, file = "index.ts"},["3940"] = {line = 432, file = "index.ts"},["3941"] = {line = 433, file = "index.ts"},["3942"] = {line = 434, file = "index.ts"},["3944"] = {line = 436, file = "index.ts"},["3945"] = {line = 437, file = "index.ts"},["3946"] = {line = 436, file = "index.ts"},["3947"] = {line = 439, file = "index.ts"},["3948"] = {line = 440, file = "index.ts"},["3949"] = {line = 441, file = "index.ts"},["3950"] = {line = 442, file = "index.ts"},["3952"] = {line = 444, file = "index.ts"},["3953"] = {line = 445, file = "index.ts"},["3955"] = {line = 447, file = "index.ts"},["3956"] = {line = 448, file = "index.ts"},["3957"] = {line = 449, file = "index.ts"},["3960"] = {line = 452, file = "index.ts"},["3962"] = {line = 454, file = "index.ts"},["3963"] = {line = 455, file = "index.ts"},["3964"] = {line = 456, file = "index.ts"},["3965"] = {line = 457, file = "index.ts"},["3966"] = {line = 456, file = "index.ts"},["3967"] = {line = 459, file = "index.ts"},["3968"] = {line = 460, file = "index.ts"},["3969"] = {line = 461, file = "index.ts"},["3970"] = {line = 462, file = "index.ts"},["3972"] = {line = 464, file = "index.ts"},["3973"] = {line = 465, file = "index.ts"},["3974"] = {line = 466, file = "index.ts"},["3975"] = {line = 467, file = "index.ts"},["3976"] = {line = 468, file = "index.ts"},["3977"] = {line = 467, file = "index.ts"},["3978"] = {line = 470, file = "index.ts"},["3979"] = {line = 471, file = "index.ts"},["3980"] = {line = 472, file = "index.ts"},["3981"] = {line = 473, file = "index.ts"},["3982"] = {line = 474, file = "index.ts"},["3983"] = {line = 475, file = "index.ts"},["3984"] = {line = 476, file = "index.ts"},["3986"] = {line = 478, file = "index.ts"},["3988"] = {line = 481, file = "index.ts"},["3990"] = {line = 483, file = "index.ts"},["3991"] = {line = 484, file = "index.ts"},["3992"] = {line = 485, file = "index.ts"},["3993"] = {line = 488, file = "index.ts"},["3996"] = {line = 491, file = "index.ts"},["3997"] = {line = 492, file = "index.ts"},["3998"] = {line = 493, file = "index.ts"},["3999"] = {line = 494, file = "index.ts"},["4000"] = {line = 495, file = "index.ts"},["4001"] = {line = 496, file = "index.ts"},["4004"] = {line = 498, file = "index.ts"},["4008"] = {line = 502, file = "index.ts"},["4009"] = {line = 502, file = "index.ts"},["4010"] = {line = 502, file = "index.ts"},["4011"] = {line = 502, file = "index.ts"},["4012"] = {line = 503, file = "index.ts"},["4013"] = {line = 503, file = "index.ts"},["4014"] = {line = 503, file = "index.ts"},["4015"] = {line = 503, file = "index.ts"},["4017"] = {line = 505, file = "index.ts"},["4019"] = {line = 507, file = "index.ts"},["4020"] = {line = 508, file = "index.ts"},["4021"] = {line = 509, file = "index.ts"},["4023"] = {line = 511, file = "index.ts"},["4026"] = {line = 390, file = "index.ts"},["4027"] = {line = 514, file = "index.ts"},["4028"] = {line = 390, file = "index.ts"},["4044"] = {line = 1, file = "index.ts"},["4045"] = {line = 1, file = "index.ts"},["4046"] = {line = 2, file = "index.ts"},["4047"] = {line = 2, file = "index.ts"},["4048"] = {line = 3, file = "index.ts"},["4049"] = {line = 3, file = "index.ts"},["4050"] = {line = 5, file = "index.ts"},["4051"] = {line = 6, file = "index.ts"},["4052"] = {line = 7, file = "index.ts"},["4053"] = {line = 8, file = "index.ts"},["4054"] = {line = 9, file = "index.ts"},["4055"] = {line = 11, file = "index.ts"},["4056"] = {line = 12, file = "index.ts"},["4057"] = {line = 13, file = "index.ts"},["4058"] = {line = 15, file = "index.ts"},["4059"] = {line = 16, file = "index.ts"},["4060"] = {line = 17, file = "index.ts"},["4063"] = {line = 20, file = "index.ts"},["4067"] = {line = 5, file = "index.ts"},["4068"] = {line = 24, file = "index.ts"},["4069"] = {line = 25, file = "index.ts"},["4070"] = {line = 27, file = "index.ts"},["4071"] = {line = 27, file = "index.ts"},["4072"] = {line = 39, file = "index.ts"},["4073"] = {line = 40, file = "index.ts"},["4074"] = {line = 40, file = "index.ts"},["4075"] = {line = 40, file = "index.ts"},["4076"] = {line = 40, file = "index.ts"},["4077"] = {line = 40, file = "index.ts"},["4078"] = {line = 41, file = "index.ts"},["4079"] = {line = 42, file = "index.ts"},["4080"] = {line = 43, file = "index.ts"},["4081"] = {line = 41, file = "index.ts"},["4082"] = {line = 39, file = "index.ts"},["4083"] = {line = 27, file = "index.ts"},["4084"] = {line = 47, file = "index.ts"},["4085"] = {line = 24, file = "index.ts"},["4086"] = {line = 50, file = "index.ts"},["4087"] = {line = 51, file = "index.ts"},["4088"] = {line = 52, file = "index.ts"},["4089"] = {line = 55, file = "index.ts"},["4090"] = {line = 56, file = "index.ts"},["4091"] = {line = 57, file = "index.ts"},["4092"] = {line = 50, file = "index.ts"},["4093"] = {line = 60, file = "index.ts"},["4094"] = {line = 61, file = "index.ts"},["4095"] = {line = 61, file = "index.ts"},["4098"] = {line = 63, file = "index.ts"},["4102"] = {line = 66, file = "index.ts"},["4103"] = {line = 67, file = "index.ts"},["4104"] = {line = 68, file = "index.ts"},["4105"] = {line = 69, file = "index.ts"},["4106"] = {line = 70, file = "index.ts"},["4107"] = {line = 71, file = "index.ts"},["4108"] = {line = 71, file = "index.ts"},["4109"] = {line = 71, file = "index.ts"},["4110"] = {line = 72, file = "index.ts"},["4111"] = {line = 73, file = "index.ts"},["4112"] = {line = 74, file = "index.ts"},["4113"] = {line = 75, file = "index.ts"},["4114"] = {line = 75, file = "index.ts"},["4115"] = {line = 75, file = "index.ts"},["4116"] = {line = 75, file = "index.ts"},["4117"] = {line = 76, file = "index.ts"},["4119"] = {line = 79, file = "index.ts"},["4121"] = {line = 73, file = "index.ts"},["4122"] = {line = 71, file = "index.ts"},["4123"] = {line = 82, file = "index.ts"},["4124"] = {line = 83, file = "index.ts"},["4127"] = {line = 84, file = "index.ts"},["4128"] = {line = 85, file = "index.ts"},["4129"] = {line = 86, file = "index.ts"},["4130"] = {line = 86, file = "index.ts"},["4133"] = {line = 88, file = "index.ts"},["4134"] = {line = 89, file = "index.ts"},["4138"] = {line = 92, file = "index.ts"},["4139"] = {line = 82, file = "index.ts"},["4140"] = {line = 71, file = "index.ts"},["4141"] = {line = 60, file = "index.ts"},["4142"] = {line = 96, file = "index.ts"},["4143"] = {line = 97, file = "index.ts"},["4144"] = {line = 97, file = "index.ts"},["4145"] = {line = 97, file = "index.ts"},["4146"] = {line = 97, file = "index.ts"},["4147"] = {line = 97, file = "index.ts"},["4148"] = {line = 98, file = "index.ts"},["4150"] = {line = 101, file = "index.ts"},["4152"] = {line = 96, file = "index.ts"},["4153"] = {line = 105, file = "index.ts"},["4154"] = {line = 106, file = "index.ts"},["4155"] = {line = 107, file = "index.ts"},["4156"] = {line = 108, file = "index.ts"},["4157"] = {line = 109, file = "index.ts"},["4158"] = {line = 110, file = "index.ts"},["4159"] = {line = 111, file = "index.ts"},["4160"] = {line = 112, file = "index.ts"},["4161"] = {line = 113, file = "index.ts"},["4162"] = {line = 115, file = "index.ts"},["4163"] = {line = 116, file = "index.ts"},["4164"] = {line = 118, file = "index.ts"},["4165"] = {line = 119, file = "index.ts"},["4167"] = {line = 122, file = "index.ts"},["4168"] = {line = 123, file = "index.ts"},["4173"] = {line = 129, file = "index.ts"},["4174"] = {line = 130, file = "index.ts"},["4175"] = {line = 131, file = "index.ts"},["4176"] = {line = 105, file = "index.ts"},["4183"] = {line = 1, file = "index.ts"},["4184"] = {line = 1, file = "index.ts"},["4185"] = {line = 2, file = "index.ts"},["4186"] = {line = 2, file = "index.ts"},["4187"] = {line = 3, file = "index.ts"},["4188"] = {line = 3, file = "index.ts"},["4189"] = {line = 4, file = "index.ts"},["4190"] = {line = 4, file = "index.ts"},["4191"] = {line = 5, file = "index.ts"},["4192"] = {line = 5, file = "index.ts"},["4193"] = {line = 6, file = "index.ts"},["4194"] = {line = 6, file = "index.ts"},["4195"] = {line = 7, file = "index.ts"},["4196"] = {line = 7, file = "index.ts"},["4197"] = {line = 8, file = "index.ts"},["4198"] = {line = 8, file = "index.ts"},["4199"] = {line = 10, file = "index.ts"},["4200"] = {line = 11, file = "index.ts"},["4201"] = {line = 12, file = "index.ts"},["4202"] = {line = 13, file = "index.ts"},["4203"] = {line = 14, file = "index.ts"},["4204"] = {line = 15, file = "index.ts"},["4205"] = {line = 16, file = "index.ts"},["4206"] = {line = 17, file = "index.ts"},["4207"] = {line = 18, file = "index.ts"},["4208"] = {line = 10, file = "index.ts"},["4215"] = {line = 48, file = "neovide.ts"},["4216"] = {line = 49, file = "neovide.ts"},["4217"] = {line = 48, file = "neovide.ts"},["4218"] = {line = 52, file = "neovide.ts"},["4219"] = {line = 53, file = "neovide.ts"},["4220"] = {line = 52, file = "neovide.ts"},["4227"] = {line = 1, file = "mainLoopCallbacks.ts"},["4228"] = {line = 2, file = "mainLoopCallbacks.ts"},["4229"] = {line = 4, file = "mainLoopCallbacks.ts"},["4230"] = {line = 5, file = "mainLoopCallbacks.ts"},["4231"] = {line = 4, file = "mainLoopCallbacks.ts"},["4232"] = {line = 8, file = "mainLoopCallbacks.ts"},["4233"] = {line = 9, file = "mainLoopCallbacks.ts"},["4234"] = {line = 10, file = "mainLoopCallbacks.ts"},["4236"] = {line = 8, file = "mainLoopCallbacks.ts"},["4237"] = {line = 14, file = "mainLoopCallbacks.ts"},["4238"] = {line = 16, file = "mainLoopCallbacks.ts"},["4239"] = {line = 1, file = "mainLoopCallbacks.ts"},["4240"] = {line = 19, file = "mainLoopCallbacks.ts"},["4241"] = {line = 20, file = "mainLoopCallbacks.ts"},["4242"] = {line = 19, file = "mainLoopCallbacks.ts"},["4243"] = {line = 23, file = "mainLoopCallbacks.ts"},["4244"] = {line = 24, file = "mainLoopCallbacks.ts"},["4245"] = {line = 25, file = "mainLoopCallbacks.ts"},["4246"] = {line = 25, file = "mainLoopCallbacks.ts"},["4247"] = {line = 26, file = "mainLoopCallbacks.ts"},["4248"] = {line = 27, file = "mainLoopCallbacks.ts"},["4249"] = {line = 28, file = "mainLoopCallbacks.ts"},["4251"] = {line = 25, file = "mainLoopCallbacks.ts"},["4252"] = {line = 32, file = "mainLoopCallbacks.ts"},["4253"] = {line = 33, file = "mainLoopCallbacks.ts"},["4254"] = {line = 32, file = "mainLoopCallbacks.ts"},["4255"] = {line = 35, file = "mainLoopCallbacks.ts"},["4256"] = {line = 36, file = "mainLoopCallbacks.ts"},["4257"] = {line = 23, file = "mainLoopCallbacks.ts"},["4258"] = {line = 39, file = "mainLoopCallbacks.ts"},["4259"] = {line = 40, file = "mainLoopCallbacks.ts"},["4260"] = {line = 39, file = "mainLoopCallbacks.ts"},["4261"] = {line = 43, file = "mainLoopCallbacks.ts"},["4262"] = {line = 44, file = "mainLoopCallbacks.ts"},["4263"] = {line = 43, file = "mainLoopCallbacks.ts"},["4264"] = {line = 46, file = "mainLoopCallbacks.ts"},["4265"] = {line = 47, file = "mainLoopCallbacks.ts"},["4266"] = {line = 48, file = "mainLoopCallbacks.ts"},["4267"] = {line = 49, file = "mainLoopCallbacks.ts"},["4268"] = {line = 50, file = "mainLoopCallbacks.ts"},["4269"] = {line = 51, file = "mainLoopCallbacks.ts"},["4270"] = {line = 52, file = "mainLoopCallbacks.ts"},["4271"] = {line = 46, file = "mainLoopCallbacks.ts"},["4291"] = {line = 1, file = "index.ts"},["4292"] = {line = 1, file = "index.ts"},["4293"] = {line = 1, file = "index.ts"},["4294"] = {line = 2, file = "index.ts"},["4295"] = {line = 2, file = "index.ts"},["4296"] = {line = 4, file = "index.ts"},["4297"] = {line = 5, file = "index.ts"},["4298"] = {line = 6, file = "index.ts"},["4299"] = {line = 7, file = "index.ts"},["4300"] = {line = 8, file = "index.ts"},["4302"] = {line = 11, file = "index.ts"},["4304"] = {line = 4, file = "index.ts"},["4305"] = {line = 15, file = "index.ts"},["4307"] = {line = 16, file = "index.ts"},["4308"] = {line = 17, file = "index.ts"},["4309"] = {line = 18, file = "index.ts"},["4310"] = {line = 18, file = "index.ts"},["4311"] = {line = 18, file = "index.ts"},["4312"] = {line = 18, file = "index.ts"},["4313"] = {line = 18, file = "index.ts"},["4314"] = {line = 18, file = "index.ts"},["4315"] = {line = 18, file = "index.ts"},["4316"] = {line = 19, file = "index.ts"},["4317"] = {line = 20, file = "index.ts"},["4318"] = {line = 20, file = "index.ts"},["4319"] = {line = 20, file = "index.ts"},["4320"] = {line = 20, file = "index.ts"},["4321"] = {line = 20, file = "index.ts"},["4322"] = {line = 20, file = "index.ts"},["4323"] = {line = 21, file = "index.ts"},["4324"] = {line = 22, file = "index.ts"},["4326"] = {line = 23, file = "index.ts"},["4330"] = {line = 25, file = "index.ts"},["4333"] = {line = 26, file = "index.ts"},["4337"] = {line = 29, file = "index.ts"},["4342"] = {line = 15, file = "index.ts"},["4349"] = {line = 10, file = "diffopt.ts"},["4350"] = {line = 11, file = "diffopt.ts"},["4351"] = {line = 13, file = "diffopt.ts"},["4352"] = {line = 14, file = "diffopt.ts"},["4353"] = {line = 15, file = "diffopt.ts"},["4355"] = {line = 18, file = "diffopt.ts"},["4357"] = {line = 13, file = "diffopt.ts"},["4358"] = {line = 22, file = "diffopt.ts"},["4359"] = {line = 23, file = "diffopt.ts"},["4361"] = {line = 26, file = "diffopt.ts"},["4362"] = {line = 27, file = "diffopt.ts"},["4364"] = {line = 30, file = "diffopt.ts"},["4365"] = {line = 31, file = "diffopt.ts"},["4367"] = {line = 34, file = "diffopt.ts"},["4368"] = {line = 35, file = "diffopt.ts"},["4370"] = {line = 38, file = "diffopt.ts"},["4371"] = {line = 39, file = "diffopt.ts"},["4373"] = {line = 42, file = "diffopt.ts"},["4374"] = {line = 43, file = "diffopt.ts"},["4376"] = {line = 46, file = "diffopt.ts"},["4377"] = {line = 10, file = "diffopt.ts"},["4390"] = {line = 1, file = "hyprland.ts"},["4391"] = {line = 2, file = "hyprland.ts"},["4392"] = {line = 1, file = "hyprland.ts"},["4393"] = {line = 6, file = "hyprland.ts"},["4394"] = {line = 7, file = "hyprland.ts"},["4395"] = {line = 7, file = "hyprland.ts"},["4396"] = {line = 7, file = "hyprland.ts"},["4397"] = {line = 7, file = "hyprland.ts"},["4398"] = {line = 7, file = "hyprland.ts"},["4399"] = {line = 7, file = "hyprland.ts"},["4400"] = {line = 7, file = "hyprland.ts"},["4401"] = {line = 10, file = "hyprland.ts"},["4402"] = {line = 10, file = "hyprland.ts"},["4403"] = {line = 10, file = "hyprland.ts"},["4404"] = {line = 10, file = "hyprland.ts"},["4405"] = {line = 10, file = "hyprland.ts"},["4406"] = {line = 10, file = "hyprland.ts"},["4407"] = {line = 10, file = "hyprland.ts"},["4408"] = {line = 10, file = "hyprland.ts"},["4409"] = {line = 10, file = "hyprland.ts"},["4410"] = {line = 10, file = "hyprland.ts"},["4411"] = {line = 13, file = "hyprland.ts"},["4412"] = {line = 14, file = "hyprland.ts"},["4413"] = {line = 15, file = "hyprland.ts"},["4414"] = {line = 16, file = "hyprland.ts"},["4415"] = {line = 13, file = "hyprland.ts"},["4416"] = {line = 19, file = "hyprland.ts"},["4417"] = {line = 19, file = "hyprland.ts"},["4418"] = {line = 19, file = "hyprland.ts"},["4419"] = {line = 19, file = "hyprland.ts"},["4420"] = {line = 6, file = "hyprland.ts"},["4421"] = {line = 22, file = "hyprland.ts"},["4432"] = {line = 1, file = "getOpenPort.ts"},["4433"] = {line = 2, file = "getOpenPort.ts"},["4434"] = {line = 3, file = "getOpenPort.ts"},["4435"] = {line = 4, file = "getOpenPort.ts"},["4436"] = {line = 5, file = "getOpenPort.ts"},["4437"] = {line = 5, file = "getOpenPort.ts"},["4438"] = {line = 5, file = "getOpenPort.ts"},["4439"] = {line = 5, file = "getOpenPort.ts"},["4440"] = {line = 5, file = "getOpenPort.ts"},["4441"] = {line = 6, file = "getOpenPort.ts"},["4442"] = {line = 6, file = "getOpenPort.ts"},["4443"] = {line = 6, file = "getOpenPort.ts"},["4444"] = {line = 6, file = "getOpenPort.ts"},["4445"] = {line = 6, file = "getOpenPort.ts"},["4446"] = {line = 6, file = "getOpenPort.ts"},["4447"] = {line = 6, file = "getOpenPort.ts"},["4448"] = {line = 7, file = "getOpenPort.ts"},["4449"] = {line = 1, file = "getOpenPort.ts"},["4457"] = {line = 1, file = "ollama.ts"},["4458"] = {line = 1, file = "ollama.ts"},["4459"] = {line = 2, file = "ollama.ts"},["4460"] = {line = 2, file = "ollama.ts"},["4461"] = {line = 3, file = "ollama.ts"},["4462"] = {line = 3, file = "ollama.ts"},["4463"] = {line = 5, file = "ollama.ts"},["4464"] = {line = 6, file = "ollama.ts"},["4465"] = {line = 7, file = "ollama.ts"},["4466"] = {line = 13, file = "ollama.ts"},["4467"] = {line = 13, file = "ollama.ts"},["4468"] = {line = 13, file = "ollama.ts"},["4469"] = {line = 13, file = "ollama.ts"},["4471"] = {line = 13, file = "ollama.ts"},["4472"] = {line = 14, file = "ollama.ts"},["4474"] = {line = 20, file = "ollama.ts"},["4475"] = {line = 21, file = "ollama.ts"},["4477"] = {line = 27, file = "ollama.ts"},["4478"] = {line = 28, file = "ollama.ts"},["4481"] = {line = 36, file = "ollama.ts"},["4482"] = {line = 38, file = "ollama.ts"},["4483"] = {line = 39, file = "ollama.ts"},["4486"] = {line = 46, file = "ollama.ts"},["4487"] = {line = 7, file = "ollama.ts"},["4488"] = {line = 51, file = "ollama.ts"},["4489"] = {line = 55, file = "ollama.ts"},["4490"] = {line = 55, file = "ollama.ts"},["4491"] = {line = 55, file = "ollama.ts"},["4492"] = {line = 55, file = "ollama.ts"},["4494"] = {line = 55, file = "ollama.ts"},["4495"] = {line = 56, file = "ollama.ts"},["4496"] = {line = 51, file = "ollama.ts"},["4497"] = {line = 59, file = "ollama.ts"},["4498"] = {line = 60, file = "ollama.ts"},["4499"] = {line = 60, file = "ollama.ts"},["4500"] = {line = 61, file = "ollama.ts"},["4501"] = {line = 62, file = "ollama.ts"},["4502"] = {line = 63, file = "ollama.ts"},["4503"] = {line = 64, file = "ollama.ts"},["4504"] = {line = 64, file = "ollama.ts"},["4505"] = {line = 64, file = "ollama.ts"},["4506"] = {line = 64, file = "ollama.ts"},["4507"] = {line = 63, file = "ollama.ts"},["4509"] = {line = 68, file = "ollama.ts"},["4510"] = {line = 69, file = "ollama.ts"},["4511"] = {line = 69, file = "ollama.ts"},["4512"] = {line = 69, file = "ollama.ts"},["4513"] = {line = 69, file = "ollama.ts"},["4514"] = {line = 70, file = "ollama.ts"},["4515"] = {line = 71, file = "ollama.ts"},["4516"] = {line = 72, file = "ollama.ts"},["4517"] = {line = 73, file = "ollama.ts"},["4519"] = {line = 76, file = "ollama.ts"},["4520"] = {line = 77, file = "ollama.ts"},["4521"] = {line = 78, file = "ollama.ts"},["4522"] = {line = 79, file = "ollama.ts"},["4523"] = {line = 80, file = "ollama.ts"},["4524"] = {line = 81, file = "ollama.ts"},["4525"] = {line = 82, file = "ollama.ts"},["4527"] = {line = 84, file = "ollama.ts"},["4528"] = {line = 85, file = "ollama.ts"},["4529"] = {line = 86, file = "ollama.ts"},["4530"] = {line = 87, file = "ollama.ts"},["4531"] = {line = 88, file = "ollama.ts"},["4534"] = {line = 92, file = "ollama.ts"},["4535"] = {line = 94, file = "ollama.ts"},["4536"] = {line = 94, file = "ollama.ts"},["4537"] = {line = 97, file = "ollama.ts"},["4538"] = {line = 97, file = "ollama.ts"},["4539"] = {line = 97, file = "ollama.ts"},["4540"] = {line = 98, file = "ollama.ts"},["4541"] = {line = 99, file = "ollama.ts"},["4542"] = {line = 100, file = "ollama.ts"},["4543"] = {line = 101, file = "ollama.ts"},["4544"] = {line = 102, file = "ollama.ts"},["4545"] = {line = 102, file = "ollama.ts"},["4546"] = {line = 102, file = "ollama.ts"},["4547"] = {line = 102, file = "ollama.ts"},["4548"] = {line = 101, file = "ollama.ts"},["4549"] = {line = 97, file = "ollama.ts"},["4550"] = {line = 97, file = "ollama.ts"},["4553"] = {line = 59, file = "ollama.ts"},["4560"] = {line = 1, file = "portable-appimage.ts"},["4561"] = {line = 2, file = "portable-appimage.ts"},["4562"] = {line = 1, file = "portable-appimage.ts"},["4563"] = {line = 7, file = "portable-appimage.ts"},["4564"] = {line = 8, file = "portable-appimage.ts"},["4565"] = {line = 9, file = "portable-appimage.ts"},["4566"] = {line = 8, file = "portable-appimage.ts"},["4567"] = {line = 7, file = "portable-appimage.ts"},["4568"] = {line = 13, file = "portable-appimage.ts"},["4569"] = {line = 14, file = "portable-appimage.ts"},["4570"] = {line = 15, file = "portable-appimage.ts"},["4571"] = {line = 17, file = "portable-appimage.ts"},["4573"] = {line = 13, file = "portable-appimage.ts"},["4581"] = {line = 3, file = "init.ts"},["4582"] = {line = 3, file = "init.ts"},["4583"] = {line = 11, file = "init.ts"},["4584"] = {line = 12, file = "init.ts"},["4585"] = {line = 13, file = "init.ts"},["4586"] = {line = 15, file = "init.ts"},["4587"] = {line = 16, file = "init.ts"},["4588"] = {line = 20, file = "init.ts"},["4589"] = {line = 22, file = "init.ts"},["4590"] = {line = 25, file = "init.ts"},["4591"] = {line = 29, file = "init.ts"},["4592"] = {line = 33, file = "init.ts"},["4593"] = {line = 37, file = "init.ts"},["4594"] = {line = 41, file = "init.ts"},["4595"] = {line = 45, file = "init.ts"},["4596"] = {line = 49, file = "init.ts"},["4597"] = {line = 53, file = "init.ts"},["4598"] = {line = 57, file = "init.ts"},["4599"] = {line = 61, file = "init.ts"},["4600"] = {line = 65, file = "init.ts"},["4601"] = {line = 69, file = "init.ts"},["4602"] = {line = 73, file = "init.ts"},["4603"] = {line = 77, file = "init.ts"},["4604"] = {line = 81, file = "init.ts"},["4605"] = {line = 85, file = "init.ts"},["4606"] = {line = 89, file = "init.ts"},["4607"] = {line = 93, file = "init.ts"},["4608"] = {line = 97, file = "init.ts"},["4609"] = {line = 101, file = "init.ts"},["4610"] = {line = 105, file = "init.ts"},["4611"] = {line = 109, file = "init.ts"},["4612"] = {line = 112, file = "init.ts"},["4613"] = {line = 115, file = "init.ts"},["4614"] = {line = 118, file = "init.ts"},["4615"] = {line = 121, file = "init.ts"},["4616"] = {line = 124, file = "init.ts"},["4617"] = {line = 127, file = "init.ts"},["4618"] = {line = 130, file = "init.ts"},["4619"] = {line = 133, file = "init.ts"},["4620"] = {line = 137, file = "init.ts"},["4621"] = {line = 141, file = "init.ts"},["4622"] = {line = 145, file = "init.ts"},["4623"] = {line = 149, file = "init.ts"},["4624"] = {line = 153, file = "init.ts"},["4625"] = {line = 157, file = "init.ts"},["4626"] = {line = 161, file = "init.ts"},["4627"] = {line = 165, file = "init.ts"},["4628"] = {line = 169, file = "init.ts"},["4629"] = {line = 173, file = "init.ts"},["4630"] = {line = 177, file = "init.ts"},["4631"] = {line = 181, file = "init.ts"},["4632"] = {line = 185, file = "init.ts"},["4633"] = {line = 189, file = "init.ts"},["4634"] = {line = 193, file = "init.ts"},["4635"] = {line = 197, file = "init.ts"},["4636"] = {line = 201, file = "init.ts"},["4637"] = {line = 205, file = "init.ts"},["4638"] = {line = 209, file = "init.ts"},["4639"] = {line = 213, file = "init.ts"},["4640"] = {line = 217, file = "init.ts"},["4641"] = {line = 221, file = "init.ts"},["4642"] = {line = 225, file = "init.ts"},["4643"] = {line = 229, file = "init.ts"},["4644"] = {line = 233, file = "init.ts"},["4645"] = {line = 237, file = "init.ts"},["4646"] = {line = 241, file = "init.ts"},["4647"] = {line = 245, file = "init.ts"},["4648"] = {line = 249, file = "init.ts"},["4649"] = {line = 253, file = "init.ts"},["4650"] = {line = 257, file = "init.ts"},["4651"] = {line = 261, file = "init.ts"},["4652"] = {line = 265, file = "init.ts"},["4653"] = {line = 269, file = "init.ts"},["4654"] = {line = 273, file = "init.ts"},["4655"] = {line = 277, file = "init.ts"},["4656"] = {line = 281, file = "init.ts"},["4657"] = {line = 285, file = "init.ts"},["4658"] = {line = 289, file = "init.ts"},["4659"] = {line = 293, file = "init.ts"},["4660"] = {line = 297, file = "init.ts"},["4661"] = {line = 301, file = "init.ts"},["4662"] = {line = 305, file = "init.ts"},["4663"] = {line = 309, file = "init.ts"},["4664"] = {line = 313, file = "init.ts"},["4665"] = {line = 317, file = "init.ts"},["4666"] = {line = 321, file = "init.ts"},["4667"] = {line = 325, file = "init.ts"},["4668"] = {line = 329, file = "init.ts"},["4669"] = {line = 15, file = "init.ts"},["4670"] = {line = 335, file = "init.ts"},["4671"] = {line = 335, file = "init.ts"},["4672"] = {line = 335, file = "init.ts"},["4673"] = {line = 335, file = "init.ts"},["4675"] = {line = 335, file = "init.ts"},["4676"] = {line = 335, file = "init.ts"},["4678"] = {line = 335, file = "init.ts"},["4679"] = {line = 335, file = "init.ts"},["4680"] = {line = 335, file = "init.ts"},["4681"] = {line = 337, file = "init.ts"},["4682"] = {line = 337, file = "init.ts"},["4683"] = {line = 337, file = "init.ts"},["4684"] = {line = 338, file = "init.ts"},["4685"] = {line = 338, file = "init.ts"},["4686"] = {line = 338, file = "init.ts"},["4687"] = {line = 338, file = "init.ts"},["4688"] = {line = 337, file = "init.ts"},["4689"] = {line = 339, file = "init.ts"},["4690"] = {line = 337, file = "init.ts"},["4691"] = {line = 343, file = "init.ts"},["4694"] = {line = 356, file = "init.ts"},["4697"] = {line = 345, file = "init.ts"},["4698"] = {line = 346, file = "init.ts"},["4699"] = {line = 347, file = "init.ts"},["4700"] = {line = 348, file = "init.ts"},["4703"] = {line = 351, file = "init.ts"},["4704"] = {line = 353, file = "init.ts"},["4712"] = {line = 359, file = "init.ts"},["4713"] = {line = 11, file = "init.ts"},["4720"] = {line = 1, file = "index.ts"},["4721"] = {line = 2, file = "index.ts"},["4722"] = {line = 2, file = "index.ts"},["4723"] = {line = 3, file = "index.ts"},["4724"] = {line = 4, file = "index.ts"},["4725"] = {line = 3, file = "index.ts"},["4726"] = {line = 6, file = "index.ts"},["4727"] = {line = 7, file = "index.ts"},["4728"] = {line = 6, file = "index.ts"},["4729"] = {line = 9, file = "index.ts"},["4730"] = {line = 10, file = "index.ts"},["4731"] = {line = 9, file = "index.ts"},["4732"] = {line = 2, file = "index.ts"},["4734"] = {line = 1, file = "index.ts"},["4741"] = {line = 1, file = "index.ts"},["4742"] = {line = 2, file = "index.ts"},["4743"] = {line = 3, file = "index.ts"},["4745"] = {line = 6, file = "index.ts"},["4746"] = {line = 7, file = "index.ts"},["4747"] = {line = 8, file = "index.ts"},["4749"] = {line = 10, file = "index.ts"},["4750"] = {line = 6, file = "index.ts"},["4751"] = {line = 12, file = "index.ts"},["4752"] = {line = 13, file = "index.ts"},["4753"] = {line = 14, file = "index.ts"},["4755"] = {line = 16, file = "index.ts"},["4756"] = {line = 12, file = "index.ts"},["4757"] = {line = 1, file = "index.ts"},["4767"] = {line = 2, file = "main.ts"},["4768"] = {line = 2, file = "main.ts"},["4769"] = {line = 3, file = "main.ts"},["4770"] = {line = 3, file = "main.ts"},["4771"] = {line = 4, file = "main.ts"},["4772"] = {line = 4, file = "main.ts"},["4773"] = {line = 5, file = "main.ts"},["4774"] = {line = 5, file = "main.ts"},["4775"] = {line = 6, file = "main.ts"},["4776"] = {line = 6, file = "main.ts"},["4777"] = {line = 7, file = "main.ts"},["4778"] = {line = 7, file = "main.ts"},["4779"] = {line = 7, file = "main.ts"},["4780"] = {line = 8, file = "main.ts"},["4781"] = {line = 8, file = "main.ts"},["4782"] = {line = 9, file = "main.ts"},["4783"] = {line = 9, file = "main.ts"},["4784"] = {line = 10, file = "main.ts"},["4785"] = {line = 10, file = "main.ts"},["4786"] = {line = 11, file = "main.ts"},["4787"] = {line = 11, file = "main.ts"},["4788"] = {line = 12, file = "main.ts"},["4789"] = {line = 12, file = "main.ts"},["4790"] = {line = 13, file = "main.ts"},["4791"] = {line = 13, file = "main.ts"},["4792"] = {line = 14, file = "main.ts"},["4793"] = {line = 14, file = "main.ts"},["4794"] = {line = 14, file = "main.ts"},["4795"] = {line = 15, file = "main.ts"},["4796"] = {line = 15, file = "main.ts"},["4797"] = {line = 17, file = "main.ts"},["4798"] = {line = 18, file = "main.ts"},["4799"] = {line = 19, file = "main.ts"},["4800"] = {line = 20, file = "main.ts"},["4801"] = {line = 22, file = "main.ts"},["4802"] = {line = 23, file = "main.ts"},["4803"] = {line = 24, file = "main.ts"},["4804"] = {line = 25, file = "main.ts"},["4805"] = {line = 27, file = "main.ts"},["4806"] = {line = 28, file = "main.ts"},["4807"] = {line = 30, file = "main.ts"},["4808"] = {line = 30, file = "main.ts"},["4809"] = {line = 30, file = "main.ts"},["4810"] = {line = 31, file = "main.ts"},["4812"] = {line = 35, file = "main.ts"},["4814"] = {line = 22, file = "main.ts"},["4815"] = {line = 44, file = "main.ts"},["4816"] = {line = 45, file = "main.ts"},["4817"] = {line = 46, file = "main.ts"},["4818"] = {line = 47, file = "main.ts"},["4819"] = {line = 48, file = "main.ts"},["4820"] = {line = 48, file = "main.ts"},["4821"] = {line = 48, file = "main.ts"},["4822"] = {line = 48, file = "main.ts"},["4823"] = {line = 48, file = "main.ts"},["4824"] = {line = 48, file = "main.ts"},["4825"] = {line = 48, file = "main.ts"},["4826"] = {line = 48, file = "main.ts"},["4828"] = {line = 51, file = "main.ts"},["4829"] = {line = 44, file = "main.ts"},["4830"] = {line = 54, file = "main.ts"},["4831"] = {line = 55, file = "main.ts"},["4832"] = {line = 56, file = "main.ts"},["4833"] = {line = 57, file = "main.ts"},["4834"] = {line = 58, file = "main.ts"},["4835"] = {line = 59, file = "main.ts"},["4836"] = {line = 60, file = "main.ts"},["4837"] = {line = 54, file = "main.ts"},["4838"] = {line = 64, file = "main.ts"},["4839"] = {line = 65, file = "main.ts"},["4840"] = {line = 66, file = "main.ts"},["4841"] = {line = 68, file = "main.ts"},["4842"] = {line = 69, file = "main.ts"},["4843"] = {line = 73, file = "main.ts"},["4844"] = {line = 76, file = "main.ts"},["4845"] = {line = 78, file = "main.ts"},["4846"] = {line = 79, file = "main.ts"},["4847"] = {line = 81, file = "main.ts"},["4848"] = {line = 83, file = "main.ts"},["4849"] = {line = 84, file = "main.ts"},["4850"] = {line = 86, file = "main.ts"},["4851"] = {line = 88, file = "main.ts"},["4852"] = {line = 90, file = "main.ts"},["4853"] = {line = 91, file = "main.ts"},["4854"] = {line = 93, file = "main.ts"},["4855"] = {line = 94, file = "main.ts"},["4856"] = {line = 95, file = "main.ts"},["4857"] = {line = 97, file = "main.ts"},["4858"] = {line = 99, file = "main.ts"},["4865"] = {line = 1, file = "index.ts"},["4866"] = {line = 1, file = "index.ts"},["4867"] = {line = 3, file = "index.ts"},["4868"] = {line = 4, file = "index.ts"},["4869"] = {line = 6, file = "index.ts"},["4870"] = {line = 11, file = "index.ts"},["4871"] = {line = 12, file = "index.ts"},["4872"] = {line = 13, file = "index.ts"},["4873"] = {line = 13, file = "index.ts"},["4876"] = {line = 15, file = "index.ts"},["4877"] = {line = 16, file = "index.ts"},["4879"] = {line = 6, file = "index.ts"},["4886"] = {line = 2, file = "actions-preview.ts"},["4887"] = {line = 2, file = "actions-preview.ts"},["4888"] = {line = 8, file = "actions-preview.ts"},["4889"] = {line = 9, file = "actions-preview.ts"},["4890"] = {line = 10, file = "actions-preview.ts"},["4891"] = {line = 11, file = "actions-preview.ts"},["4892"] = {line = 8, file = "actions-preview.ts"},["4893"] = {line = 14, file = "actions-preview.ts"},["4894"] = {line = 18, file = "actions-preview.ts"},["4901"] = {line = 2, file = "csharp.ts"},["4902"] = {line = 2, file = "csharp.ts"},["4903"] = {line = 3, file = "csharp.ts"},["4904"] = {line = 3, file = "csharp.ts"},["4905"] = {line = 4, file = "csharp.ts"},["4906"] = {line = 4, file = "csharp.ts"},["4907"] = {line = 6, file = "csharp.ts"},["4908"] = {line = 11, file = "csharp.ts"},["4909"] = {line = 6, file = "csharp.ts"},["4910"] = {line = 14, file = "csharp.ts"},["4911"] = {line = 15, file = "csharp.ts"},["4912"] = {line = 16, file = "csharp.ts"},["4913"] = {line = 17, file = "csharp.ts"},["4914"] = {line = 18, file = "csharp.ts"},["4915"] = {line = 18, file = "csharp.ts"},["4916"] = {line = 19, file = "csharp.ts"},["4917"] = {line = 20, file = "csharp.ts"},["4918"] = {line = 21, file = "csharp.ts"},["4919"] = {line = 20, file = "csharp.ts"},["4921"] = {line = 25, file = "csharp.ts"},["4924"] = {line = 29, file = "csharp.ts"},["4925"] = {line = 30, file = "csharp.ts"},["4926"] = {line = 29, file = "csharp.ts"},["4928"] = {line = 17, file = "csharp.ts"},["4929"] = {line = 14, file = "csharp.ts"},["4930"] = {line = 35, file = "csharp.ts"},["4945"] = {line = 2, file = "nvim-dap-ui.ts"},["4946"] = {line = 2, file = "nvim-dap-ui.ts"},["4947"] = {line = 3, file = "nvim-dap-ui.ts"},["4948"] = {line = 3, file = "nvim-dap-ui.ts"},["4949"] = {line = 76, file = "nvim-dap-ui.ts"},["4950"] = {line = 77, file = "nvim-dap-ui.ts"},["4951"] = {line = 78, file = "nvim-dap-ui.ts"},["4952"] = {line = 79, file = "nvim-dap-ui.ts"},["4953"] = {line = 76, file = "nvim-dap-ui.ts"},["4954"] = {line = 82, file = "nvim-dap-ui.ts"},["4955"] = {line = 83, file = "nvim-dap-ui.ts"},["4956"] = {line = 84, file = "nvim-dap-ui.ts"},["4957"] = {line = 85, file = "nvim-dap-ui.ts"},["4958"] = {line = 82, file = "nvim-dap-ui.ts"},["4959"] = {line = 88, file = "nvim-dap-ui.ts"},["4960"] = {line = 89, file = "nvim-dap-ui.ts"},["4961"] = {line = 90, file = "nvim-dap-ui.ts"},["4962"] = {line = 92, file = "nvim-dap-ui.ts"},["4963"] = {line = 92, file = "nvim-dap-ui.ts"},["4964"] = {line = 92, file = "nvim-dap-ui.ts"},["4965"] = {line = 93, file = "nvim-dap-ui.ts"},["4966"] = {line = 93, file = "nvim-dap-ui.ts"},["4967"] = {line = 93, file = "nvim-dap-ui.ts"},["4968"] = {line = 94, file = "nvim-dap-ui.ts"},["4969"] = {line = 94, file = "nvim-dap-ui.ts"},["4970"] = {line = 94, file = "nvim-dap-ui.ts"},["4971"] = {line = 95, file = "nvim-dap-ui.ts"},["4972"] = {line = 95, file = "nvim-dap-ui.ts"},["4973"] = {line = 95, file = "nvim-dap-ui.ts"},["4974"] = {line = 88, file = "nvim-dap-ui.ts"},["4975"] = {line = 100, file = "nvim-dap-ui.ts"},["4976"] = {line = 101, file = "nvim-dap-ui.ts"},["4977"] = {line = 102, file = "nvim-dap-ui.ts"},["4978"] = {line = 103, file = "nvim-dap-ui.ts"},["4979"] = {line = 103, file = "nvim-dap-ui.ts"},["4980"] = {line = 103, file = "nvim-dap-ui.ts"},["4981"] = {line = 103, file = "nvim-dap-ui.ts"},["4982"] = {line = 103, file = "nvim-dap-ui.ts"},["4983"] = {line = 104, file = "nvim-dap-ui.ts"},["4984"] = {line = 105, file = "nvim-dap-ui.ts"},["4986"] = {line = 106, file = "nvim-dap-ui.ts"},["4991"] = {line = 109, file = "nvim-dap-ui.ts"},["4992"] = {line = 101, file = "nvim-dap-ui.ts"},["4993"] = {line = 112, file = "nvim-dap-ui.ts"},["4994"] = {line = 112, file = "nvim-dap-ui.ts"},["4995"] = {line = 112, file = "nvim-dap-ui.ts"},["4996"] = {line = 114, file = "nvim-dap-ui.ts"},["4997"] = {line = 113, file = "nvim-dap-ui.ts"},["4998"] = {line = 112, file = "nvim-dap-ui.ts"},["4999"] = {line = 127, file = "nvim-dap-ui.ts"},["5000"] = {line = 128, file = "nvim-dap-ui.ts"},["5001"] = {line = 129, file = "nvim-dap-ui.ts"},["5003"] = {line = 131, file = "nvim-dap-ui.ts"},["5004"] = {line = 127, file = "nvim-dap-ui.ts"},["5005"] = {line = 134, file = "nvim-dap-ui.ts"},["5006"] = {line = 135, file = "nvim-dap-ui.ts"},["5007"] = {line = 136, file = "nvim-dap-ui.ts"},["5008"] = {line = 138, file = "nvim-dap-ui.ts"},["5009"] = {line = 147, file = "nvim-dap-ui.ts"},["5010"] = {line = 148, file = "nvim-dap-ui.ts"},["5011"] = {line = 148, file = "nvim-dap-ui.ts"},["5012"] = {line = 148, file = "nvim-dap-ui.ts"},["5013"] = {line = 148, file = "nvim-dap-ui.ts"},["5014"] = {line = 149, file = "nvim-dap-ui.ts"},["5015"] = {line = 150, file = "nvim-dap-ui.ts"},["5016"] = {line = 151, file = "nvim-dap-ui.ts"},["5017"] = {line = 152, file = "nvim-dap-ui.ts"},["5018"] = {line = 153, file = "nvim-dap-ui.ts"},["5019"] = {line = 154, file = "nvim-dap-ui.ts"},["5020"] = {line = 155, file = "nvim-dap-ui.ts"},["5021"] = {line = 156, file = "nvim-dap-ui.ts"},["5022"] = {line = 157, file = "nvim-dap-ui.ts"},["5023"] = {line = 158, file = "nvim-dap-ui.ts"},["5024"] = {line = 159, file = "nvim-dap-ui.ts"},["5025"] = {line = 156, file = "nvim-dap-ui.ts"},["5026"] = {line = 161, file = "nvim-dap-ui.ts"},["5027"] = {line = 149, file = "nvim-dap-ui.ts"},["5028"] = {line = 148, file = "nvim-dap-ui.ts"},["5029"] = {line = 148, file = "nvim-dap-ui.ts"},["5032"] = {line = 168, file = "nvim-dap-ui.ts"},["5033"] = {line = 169, file = "nvim-dap-ui.ts"},["5034"] = {line = 177, file = "nvim-dap-ui.ts"},["5036"] = {line = 179, file = "nvim-dap-ui.ts"},["5037"] = {line = 180, file = "nvim-dap-ui.ts"},["5038"] = {line = 185, file = "nvim-dap-ui.ts"},["5039"] = {line = 187, file = "nvim-dap-ui.ts"},["5040"] = {line = 188, file = "nvim-dap-ui.ts"},["5041"] = {line = 189, file = "nvim-dap-ui.ts"},["5042"] = {line = 190, file = "nvim-dap-ui.ts"},["5043"] = {line = 191, file = "nvim-dap-ui.ts"},["5044"] = {line = 192, file = "nvim-dap-ui.ts"},["5045"] = {line = 193, file = "nvim-dap-ui.ts"},["5046"] = {line = 194, file = "nvim-dap-ui.ts"},["5047"] = {line = 195, file = "nvim-dap-ui.ts"},["5048"] = {line = 196, file = "nvim-dap-ui.ts"},["5049"] = {line = 197, file = "nvim-dap-ui.ts"},["5050"] = {line = 198, file = "nvim-dap-ui.ts"},["5051"] = {line = 199, file = "nvim-dap-ui.ts"},["5052"] = {line = 187, file = "nvim-dap-ui.ts"},["5055"] = {line = 134, file = "nvim-dap-ui.ts"},["5056"] = {line = 205, file = "nvim-dap-ui.ts"},["5057"] = {line = 206, file = "nvim-dap-ui.ts"},["5058"] = {line = 207, file = "nvim-dap-ui.ts"},["5059"] = {line = 207, file = "nvim-dap-ui.ts"},["5060"] = {line = 208, file = "nvim-dap-ui.ts"},["5061"] = {line = 209, file = "nvim-dap-ui.ts"},["5064"] = {line = 212, file = "nvim-dap-ui.ts"},["5065"] = {line = 213, file = "nvim-dap-ui.ts"},["5066"] = {line = 213, file = "nvim-dap-ui.ts"},["5067"] = {line = 215, file = "nvim-dap-ui.ts"},["5068"] = {line = 216, file = "nvim-dap-ui.ts"},["5069"] = {line = 217, file = "nvim-dap-ui.ts"},["5070"] = {line = 218, file = "nvim-dap-ui.ts"},["5071"] = {line = 219, file = "nvim-dap-ui.ts"},["5072"] = {line = 220, file = "nvim-dap-ui.ts"},["5073"] = {line = 221, file = "nvim-dap-ui.ts"},["5074"] = {line = 222, file = "nvim-dap-ui.ts"},["5075"] = {line = 222, file = "nvim-dap-ui.ts"},["5076"] = {line = 222, file = "nvim-dap-ui.ts"},["5077"] = {line = 222, file = "nvim-dap-ui.ts"},["5078"] = {line = 222, file = "nvim-dap-ui.ts"},["5079"] = {line = 220, file = "nvim-dap-ui.ts"},["5080"] = {line = 216, file = "nvim-dap-ui.ts"},["5081"] = {line = 226, file = "nvim-dap-ui.ts"},["5082"] = {line = 227, file = "nvim-dap-ui.ts"},["5083"] = {line = 228, file = "nvim-dap-ui.ts"},["5084"] = {line = 229, file = "nvim-dap-ui.ts"},["5085"] = {line = 230, file = "nvim-dap-ui.ts"},["5086"] = {line = 231, file = "nvim-dap-ui.ts"},["5087"] = {line = 232, file = "nvim-dap-ui.ts"},["5088"] = {line = 233, file = "nvim-dap-ui.ts"},["5089"] = {line = 234, file = "nvim-dap-ui.ts"},["5090"] = {line = 235, file = "nvim-dap-ui.ts"},["5091"] = {line = 227, file = "nvim-dap-ui.ts"},["5094"] = {line = 239, file = "nvim-dap-ui.ts"},["5095"] = {line = 240, file = "nvim-dap-ui.ts"},["5096"] = {line = 240, file = "nvim-dap-ui.ts"},["5097"] = {line = 240, file = "nvim-dap-ui.ts"},["5098"] = {line = 241, file = "nvim-dap-ui.ts"},["5099"] = {line = 241, file = "nvim-dap-ui.ts"},["5100"] = {line = 241, file = "nvim-dap-ui.ts"},["5101"] = {line = 241, file = "nvim-dap-ui.ts"},["5103"] = {line = 241, file = "nvim-dap-ui.ts"},["5104"] = {line = 240, file = "nvim-dap-ui.ts"},["5105"] = {line = 240, file = "nvim-dap-ui.ts"},["5106"] = {line = 243, file = "nvim-dap-ui.ts"},["5107"] = {line = 253, file = "nvim-dap-ui.ts"},["5108"] = {line = 259, file = "nvim-dap-ui.ts"},["5109"] = {line = 260, file = "nvim-dap-ui.ts"},["5110"] = {line = 260, file = "nvim-dap-ui.ts"},["5111"] = {line = 262, file = "nvim-dap-ui.ts"},["5112"] = {line = 263, file = "nvim-dap-ui.ts"},["5113"] = {line = 264, file = "nvim-dap-ui.ts"},["5114"] = {line = 265, file = "nvim-dap-ui.ts"},["5115"] = {line = 266, file = "nvim-dap-ui.ts"},["5116"] = {line = 267, file = "nvim-dap-ui.ts"},["5117"] = {line = 268, file = "nvim-dap-ui.ts"},["5118"] = {line = 269, file = "nvim-dap-ui.ts"},["5119"] = {line = 270, file = "nvim-dap-ui.ts"},["5120"] = {line = 271, file = "nvim-dap-ui.ts"},["5121"] = {line = 272, file = "nvim-dap-ui.ts"},["5122"] = {line = 273, file = "nvim-dap-ui.ts"},["5123"] = {line = 274, file = "nvim-dap-ui.ts"},["5124"] = {line = 262, file = "nvim-dap-ui.ts"},["5128"] = {line = 205, file = "nvim-dap-ui.ts"},["5129"] = {line = 281, file = "nvim-dap-ui.ts"},["5130"] = {line = 282, file = "nvim-dap-ui.ts"},["5131"] = {line = 283, file = "nvim-dap-ui.ts"},["5132"] = {line = 284, file = "nvim-dap-ui.ts"},["5133"] = {line = 285, file = "nvim-dap-ui.ts"},["5134"] = {line = 286, file = "nvim-dap-ui.ts"},["5135"] = {line = 288, file = "nvim-dap-ui.ts"},["5136"] = {line = 289, file = "nvim-dap-ui.ts"},["5137"] = {line = 284, file = "nvim-dap-ui.ts"},["5138"] = {line = 281, file = "nvim-dap-ui.ts"},["5139"] = {line = 292, file = "nvim-dap-ui.ts"},["5146"] = {line = 1, file = "mappings.ts"},["5147"] = {line = 1, file = "mappings.ts"},["5148"] = {line = 1, file = "mappings.ts"},["5149"] = {line = 2, file = "mappings.ts"},["5150"] = {line = 2, file = "mappings.ts"},["5151"] = {line = 3, file = "mappings.ts"},["5152"] = {line = 3, file = "mappings.ts"},["5153"] = {line = 4, file = "mappings.ts"},["5154"] = {line = 4, file = "mappings.ts"},["5155"] = {line = 5, file = "mappings.ts"},["5156"] = {line = 5, file = "mappings.ts"},["5157"] = {line = 6, file = "mappings.ts"},["5158"] = {line = 6, file = "mappings.ts"},["5159"] = {line = 7, file = "mappings.ts"},["5160"] = {line = 7, file = "mappings.ts"},["5161"] = {line = 7, file = "mappings.ts"},["5162"] = {line = 9, file = "mappings.ts"},["5163"] = {line = 11, file = "mappings.ts"},["5164"] = {line = 12, file = "mappings.ts"},["5165"] = {line = 17, file = "mappings.ts"},["5166"] = {line = 18, file = "mappings.ts"},["5167"] = {line = 19, file = "mappings.ts"},["5168"] = {line = 20, file = "mappings.ts"},["5169"] = {line = 21, file = "mappings.ts"},["5170"] = {line = 21, file = "mappings.ts"},["5171"] = {line = 21, file = "mappings.ts"},["5172"] = {line = 21, file = "mappings.ts"},["5173"] = {line = 20, file = "mappings.ts"},["5174"] = {line = 17, file = "mappings.ts"},["5175"] = {line = 25, file = "mappings.ts"},["5176"] = {line = 45, file = "mappings.ts"},["5177"] = {line = 46, file = "mappings.ts"},["5178"] = {line = 47, file = "mappings.ts"},["5180"] = {line = 58, file = "mappings.ts"},["5181"] = {line = 59, file = "mappings.ts"},["5182"] = {line = 60, file = "mappings.ts"},["5184"] = {line = 70, file = "mappings.ts"},["5185"] = {line = 72, file = "mappings.ts"},["5186"] = {line = 73, file = "mappings.ts"},["5187"] = {line = 74, file = "mappings.ts"},["5188"] = {line = 75, file = "mappings.ts"},["5190"] = {line = 78, file = "mappings.ts"},["5192"] = {line = 72, file = "mappings.ts"},["5194"] = {line = 83, file = "mappings.ts"},["5195"] = {line = 84, file = "mappings.ts"},["5196"] = {line = 85, file = "mappings.ts"},["5197"] = {line = 93, file = "mappings.ts"},["5198"] = {line = 101, file = "mappings.ts"},["5199"] = {line = 110, file = "mappings.ts"},["5201"] = {line = 119, file = "mappings.ts"},["5202"] = {line = 127, file = "mappings.ts"},["5203"] = {line = 136, file = "mappings.ts"},["5204"] = {line = 144, file = "mappings.ts"},["5207"] = {line = 156, file = "mappings.ts"},["5208"] = {line = 166, file = "mappings.ts"},["5209"] = {line = 176, file = "mappings.ts"},["5210"] = {line = 186, file = "mappings.ts"},["5212"] = {line = 196, file = "mappings.ts"},["5213"] = {line = 197, file = "mappings.ts"},["5214"] = {line = 198, file = "mappings.ts"},["5215"] = {line = 199, file = "mappings.ts"},["5217"] = {line = 208, file = "mappings.ts"},["5218"] = {line = 217, file = "mappings.ts"},["5219"] = {line = 218, file = "mappings.ts"},["5220"] = {line = 219, file = "mappings.ts"},["5221"] = {line = 220, file = "mappings.ts"},["5222"] = {line = 221, file = "mappings.ts"},["5223"] = {line = 222, file = "mappings.ts"},["5224"] = {line = 221, file = "mappings.ts"},["5225"] = {line = 224, file = "mappings.ts"},["5226"] = {line = 218, file = "mappings.ts"},["5228"] = {line = 230, file = "mappings.ts"},["5229"] = {line = 239, file = "mappings.ts"},["5230"] = {line = 248, file = "mappings.ts"},["5233"] = {line = 261, file = "mappings.ts"},["5235"] = {line = 273, file = "mappings.ts"},["5236"] = {line = 274, file = "mappings.ts"},["5237"] = {line = 275, file = "mappings.ts"},["5238"] = {line = 283, file = "mappings.ts"},["5239"] = {line = 291, file = "mappings.ts"},["5240"] = {line = 299, file = "mappings.ts"},["5241"] = {line = 307, file = "mappings.ts"},["5242"] = {line = 315, file = "mappings.ts"},["5246"] = {line = 330, file = "mappings.ts"},["5247"] = {line = 331, file = "mappings.ts"},["5248"] = {line = 332, file = "mappings.ts"},["5249"] = {line = 333, file = "mappings.ts"},["5250"] = {line = 334, file = "mappings.ts"},["5251"] = {line = 335, file = "mappings.ts"},["5252"] = {line = 336, file = "mappings.ts"},["5253"] = {line = 335, file = "mappings.ts"},["5254"] = {line = 338, file = "mappings.ts"},["5255"] = {line = 332, file = "mappings.ts"},["5256"] = {line = 343, file = "mappings.ts"},["5257"] = {line = 344, file = "mappings.ts"},["5258"] = {line = 345, file = "mappings.ts"},["5259"] = {line = 346, file = "mappings.ts"},["5260"] = {line = 347, file = "mappings.ts"},["5261"] = {line = 348, file = "mappings.ts"},["5262"] = {line = 346, file = "mappings.ts"},["5263"] = {line = 350, file = "mappings.ts"},["5264"] = {line = 343, file = "mappings.ts"},["5265"] = {line = 354, file = "mappings.ts"},["5266"] = {line = 355, file = "mappings.ts"},["5267"] = {line = 356, file = "mappings.ts"},["5268"] = {line = 357, file = "mappings.ts"},["5269"] = {line = 358, file = "mappings.ts"},["5270"] = {line = 357, file = "mappings.ts"},["5271"] = {line = 360, file = "mappings.ts"},["5272"] = {line = 354, file = "mappings.ts"},["5276"] = {line = 369, file = "mappings.ts"},["5277"] = {line = 370, file = "mappings.ts"},["5278"] = {line = 371, file = "mappings.ts"},["5279"] = {line = 372, file = "mappings.ts"},["5280"] = {line = 373, file = "mappings.ts"},["5281"] = {line = 374, file = "mappings.ts"},["5282"] = {line = 375, file = "mappings.ts"},["5283"] = {line = 374, file = "mappings.ts"},["5284"] = {line = 377, file = "mappings.ts"},["5285"] = {line = 371, file = "mappings.ts"},["5286"] = {line = 381, file = "mappings.ts"},["5287"] = {line = 382, file = "mappings.ts"},["5288"] = {line = 383, file = "mappings.ts"},["5289"] = {line = 384, file = "mappings.ts"},["5290"] = {line = 385, file = "mappings.ts"},["5291"] = {line = 384, file = "mappings.ts"},["5292"] = {line = 387, file = "mappings.ts"},["5293"] = {line = 381, file = "mappings.ts"},["5295"] = {line = 392, file = "mappings.ts"},["5296"] = {line = 392, file = "mappings.ts"},["5297"] = {line = 392, file = "mappings.ts"},["5298"] = {line = 393, file = "mappings.ts"},["5299"] = {line = 392, file = "mappings.ts"},["5300"] = {line = 392, file = "mappings.ts"},["5303"] = {line = 398, file = "mappings.ts"},["5304"] = {line = 398, file = "mappings.ts"},["5305"] = {line = 399, file = "mappings.ts"},["5307"] = {line = 409, file = "mappings.ts"},["5308"] = {line = 410, file = "mappings.ts"},["5309"] = {line = 411, file = "mappings.ts"},["5310"] = {line = 412, file = "mappings.ts"},["5311"] = {line = 413, file = "mappings.ts"},["5312"] = {line = 414, file = "mappings.ts"},["5313"] = {line = 413, file = "mappings.ts"},["5314"] = {line = 416, file = "mappings.ts"},["5315"] = {line = 410, file = "mappings.ts"},["5317"] = {line = 422, file = "mappings.ts"},["5318"] = {line = 422, file = "mappings.ts"},["5319"] = {line = 423, file = "mappings.ts"},["5320"] = {line = 431, file = "mappings.ts"},["5321"] = {line = 439, file = "mappings.ts"},["5322"] = {line = 447, file = "mappings.ts"},["5324"] = {line = 457, file = "mappings.ts"},["5325"] = {line = 458, file = "mappings.ts"},["5326"] = {line = 466, file = "mappings.ts"},["5327"] = {line = 467, file = "mappings.ts"},["5328"] = {line = 468, file = "mappings.ts"},["5329"] = {line = 469, file = "mappings.ts"},["5330"] = {line = 470, file = "mappings.ts"},["5331"] = {line = 470, file = "mappings.ts"},["5332"] = {line = 473, file = "mappings.ts"},["5334"] = {line = 475, file = "mappings.ts"},["5336"] = {line = 475, file = "mappings.ts"},["5337"] = {line = 475, file = "mappings.ts"},["5339"] = {line = 475, file = "mappings.ts"},["5340"] = {line = 478, file = "mappings.ts"},["5341"] = {line = 480, file = "mappings.ts"},["5343"] = {line = 484, file = "mappings.ts"},["5346"] = {line = 489, file = "mappings.ts"},["5348"] = {line = 469, file = "mappings.ts"},["5349"] = {line = 492, file = "mappings.ts"},["5350"] = {line = 466, file = "mappings.ts"},["5351"] = {line = 496, file = "mappings.ts"},["5352"] = {line = 497, file = "mappings.ts"},["5353"] = {line = 498, file = "mappings.ts"},["5354"] = {line = 499, file = "mappings.ts"},["5355"] = {line = 500, file = "mappings.ts"},["5356"] = {line = 499, file = "mappings.ts"},["5357"] = {line = 502, file = "mappings.ts"},["5358"] = {line = 496, file = "mappings.ts"},["5359"] = {line = 506, file = "mappings.ts"},["5360"] = {line = 514, file = "mappings.ts"},["5361"] = {line = 522, file = "mappings.ts"},["5362"] = {line = 530, file = "mappings.ts"},["5363"] = {line = 531, file = "mappings.ts"},["5364"] = {line = 532, file = "mappings.ts"},["5365"] = {line = 533, file = "mappings.ts"},["5366"] = {line = 534, file = "mappings.ts"},["5367"] = {line = 533, file = "mappings.ts"},["5368"] = {line = 536, file = "mappings.ts"},["5369"] = {line = 530, file = "mappings.ts"},["5370"] = {line = 541, file = "mappings.ts"},["5371"] = {line = 542, file = "mappings.ts"},["5372"] = {line = 543, file = "mappings.ts"},["5373"] = {line = 544, file = "mappings.ts"},["5374"] = {line = 545, file = "mappings.ts"},["5375"] = {line = 544, file = "mappings.ts"},["5376"] = {line = 547, file = "mappings.ts"},["5377"] = {line = 541, file = "mappings.ts"},["5378"] = {line = 551, file = "mappings.ts"},["5379"] = {line = 552, file = "mappings.ts"},["5380"] = {line = 553, file = "mappings.ts"},["5381"] = {line = 554, file = "mappings.ts"},["5382"] = {line = 555, file = "mappings.ts"},["5383"] = {line = 554, file = "mappings.ts"},["5384"] = {line = 557, file = "mappings.ts"},["5385"] = {line = 551, file = "mappings.ts"},["5387"] = {line = 565, file = "mappings.ts"},["5388"] = {line = 565, file = "mappings.ts"},["5389"] = {line = 566, file = "mappings.ts"},["5390"] = {line = 567, file = "mappings.ts"},["5391"] = {line = 568, file = "mappings.ts"},["5392"] = {line = 569, file = "mappings.ts"},["5393"] = {line = 570, file = "mappings.ts"},["5394"] = {line = 569, file = "mappings.ts"},["5395"] = {line = 572, file = "mappings.ts"},["5396"] = {line = 566, file = "mappings.ts"},["5398"] = {line = 578, file = "mappings.ts"},["5399"] = {line = 578, file = "mappings.ts"},["5400"] = {line = 579, file = "mappings.ts"},["5402"] = {line = 590, file = "mappings.ts"},["5419"] = {line = 1, file = "index.ts"},["5420"] = {line = 1, file = "index.ts"},["5421"] = {line = 2, file = "index.ts"},["5422"] = {line = 2, file = "index.ts"},["5423"] = {line = 5, file = "index.ts"},["5424"] = {line = 6, file = "index.ts"},["5425"] = {line = 7, file = "index.ts"},["5426"] = {line = 8, file = "index.ts"},["5428"] = {line = 9, file = "index.ts"},["5432"] = {line = 11, file = "index.ts"},["5433"] = {line = 5, file = "index.ts"},["5434"] = {line = 14, file = "index.ts"},["5435"] = {line = 15, file = "index.ts"},["5436"] = {line = 16, file = "index.ts"},["5437"] = {line = 16, file = "index.ts"},["5438"] = {line = 16, file = "index.ts"},["5439"] = {line = 16, file = "index.ts"},["5440"] = {line = 16, file = "index.ts"},["5441"] = {line = 16, file = "index.ts"},["5442"] = {line = 16, file = "index.ts"},["5443"] = {line = 16, file = "index.ts"},["5444"] = {line = 16, file = "index.ts"},["5445"] = {line = 16, file = "index.ts"},["5446"] = {line = 16, file = "index.ts"},["5447"] = {line = 17, file = "index.ts"},["5448"] = {line = 17, file = "index.ts"},["5449"] = {line = 29, file = "index.ts"},["5450"] = {line = 30, file = "index.ts"},["5451"] = {line = 31, file = "index.ts"},["5452"] = {line = 32, file = "index.ts"},["5454"] = {line = 30, file = "index.ts"},["5455"] = {line = 35, file = "index.ts"},["5456"] = {line = 29, file = "index.ts"},["5457"] = {line = 17, file = "index.ts"},["5458"] = {line = 37, file = "index.ts"},["5459"] = {line = 14, file = "index.ts"},["5460"] = {line = 40, file = "index.ts"},["5461"] = {line = 41, file = "index.ts"},["5462"] = {line = 41, file = "index.ts"},["5463"] = {line = 41, file = "index.ts"},["5464"] = {line = 42, file = "index.ts"},["5465"] = {line = 41, file = "index.ts"},["5466"] = {line = 43, file = "index.ts"},["5467"] = {line = 41, file = "index.ts"},["5468"] = {line = 40, file = "index.ts"},["5475"] = {line = 1, file = "center.ts"},["5476"] = {line = 1, file = "center.ts"},["5477"] = {line = 1, file = "center.ts"},["5479"] = {line = 2, file = "center.ts"},["5480"] = {line = 3, file = "center.ts"},["5482"] = {line = 5, file = "center.ts"},["5483"] = {line = 1, file = "center.ts"},["5490"] = {line = 24, file = "index.ts"},["5491"] = {line = 25, file = "index.ts"},["5492"] = {line = 24, file = "index.ts"},["5499"] = {line = 1, file = "index.ts"},["5500"] = {line = 2, file = "index.ts"},["5501"] = {line = 3, file = "index.ts"},["5502"] = {line = 5, file = "index.ts"},["5503"] = {line = 6, file = "index.ts"},["5505"] = {line = 8, file = "index.ts"},["5506"] = {line = 11, file = "index.ts"},["5507"] = {line = 1, file = "index.ts"},["5514"] = {line = 3, file = "autopairs.ts"},["5515"] = {line = 8, file = "autopairs.ts"},["5522"] = {line = 3, file = "barbar.ts"},["5523"] = {line = 4, file = "barbar.ts"},["5524"] = {line = 5, file = "barbar.ts"},["5525"] = {line = 6, file = "barbar.ts"},["5526"] = {line = 7, file = "barbar.ts"},["5527"] = {line = 6, file = "barbar.ts"},["5528"] = {line = 9, file = "barbar.ts"},["5529"] = {line = 3, file = "barbar.ts"},["5530"] = {line = 15, file = "barbar.ts"},["5537"] = {line = 2, file = "bluloco.ts"},["5538"] = {line = 2, file = "bluloco.ts"},["5539"] = {line = 4, file = "bluloco.ts"},["5540"] = {line = 5, file = "bluloco.ts"},["5541"] = {line = 6, file = "bluloco.ts"},["5542"] = {line = 7, file = "bluloco.ts"},["5543"] = {line = 8, file = "bluloco.ts"},["5544"] = {line = 9, file = "bluloco.ts"},["5545"] = {line = 10, file = "bluloco.ts"},["5546"] = {line = 11, file = "bluloco.ts"},["5547"] = {line = 12, file = "bluloco.ts"},["5548"] = {line = 13, file = "bluloco.ts"},["5549"] = {line = 10, file = "bluloco.ts"},["5550"] = {line = 9, file = "bluloco.ts"},["5551"] = {line = 4, file = "bluloco.ts"},["5552"] = {line = 17, file = "bluloco.ts"},["5559"] = {line = 3, file = "catppuccin.ts"},["5560"] = {line = 8, file = "catppuccin.ts"},["5567"] = {line = 2, file = "cmp.ts"},["5568"] = {line = 2, file = "cmp.ts"},["5569"] = {line = 28, file = "cmp.ts"},["5570"] = {line = 29, file = "cmp.ts"},["5571"] = {line = 30, file = "cmp.ts"},["5572"] = {line = 31, file = "cmp.ts"},["5573"] = {line = 32, file = "cmp.ts"},["5574"] = {line = 33, file = "cmp.ts"},["5575"] = {line = 34, file = "cmp.ts"},["5576"] = {line = 35, file = "cmp.ts"},["5577"] = {line = 36, file = "cmp.ts"},["5578"] = {line = 37, file = "cmp.ts"},["5579"] = {line = 38, file = "cmp.ts"},["5580"] = {line = 39, file = "cmp.ts"},["5581"] = {line = 40, file = "cmp.ts"},["5582"] = {line = 41, file = "cmp.ts"},["5583"] = {line = 42, file = "cmp.ts"},["5584"] = {line = 43, file = "cmp.ts"},["5585"] = {line = 44, file = "cmp.ts"},["5586"] = {line = 45, file = "cmp.ts"},["5587"] = {line = 46, file = "cmp.ts"},["5588"] = {line = 47, file = "cmp.ts"},["5589"] = {line = 48, file = "cmp.ts"},["5590"] = {line = 49, file = "cmp.ts"},["5591"] = {line = 50, file = "cmp.ts"},["5592"] = {line = 51, file = "cmp.ts"},["5593"] = {line = 52, file = "cmp.ts"},["5594"] = {line = 53, file = "cmp.ts"},["5595"] = {line = 28, file = "cmp.ts"},["5596"] = {line = 56, file = "cmp.ts"},["5597"] = {line = 57, file = "cmp.ts"},["5598"] = {line = 58, file = "cmp.ts"},["5599"] = {line = 56, file = "cmp.ts"},["5600"] = {line = 62, file = "cmp.ts"},["5601"] = {line = 63, file = "cmp.ts"},["5602"] = {line = 64, file = "cmp.ts"},["5603"] = {line = 64, file = "cmp.ts"},["5604"] = {line = 64, file = "cmp.ts"},["5605"] = {line = 64, file = "cmp.ts"},["5606"] = {line = 64, file = "cmp.ts"},["5607"] = {line = 64, file = "cmp.ts"},["5608"] = {line = 64, file = "cmp.ts"},["5609"] = {line = 65, file = "cmp.ts"},["5610"] = {line = 66, file = "cmp.ts"},["5611"] = {line = 67, file = "cmp.ts"},["5612"] = {line = 68, file = "cmp.ts"},["5613"] = {line = 73, file = "cmp.ts"},["5614"] = {line = 80, file = "cmp.ts"},["5615"] = {line = 82, file = "cmp.ts"},["5616"] = {line = 83, file = "cmp.ts"},["5617"] = {line = 84, file = "cmp.ts"},["5618"] = {line = 85, file = "cmp.ts"},["5619"] = {line = 86, file = "cmp.ts"},["5620"] = {line = 87, file = "cmp.ts"},["5621"] = {line = 81, file = "cmp.ts"},["5622"] = {line = 90, file = "cmp.ts"},["5623"] = {line = 92, file = "cmp.ts"},["5624"] = {line = 91, file = "cmp.ts"},["5625"] = {line = 95, file = "cmp.ts"},["5626"] = {line = 98, file = "cmp.ts"},["5627"] = {line = 99, file = "cmp.ts"},["5628"] = {line = 100, file = "cmp.ts"},["5629"] = {line = 101, file = "cmp.ts"},["5630"] = {line = 102, file = "cmp.ts"},["5631"] = {line = 103, file = "cmp.ts"},["5632"] = {line = 104, file = "cmp.ts"},["5634"] = {line = 107, file = "cmp.ts"},["5636"] = {line = 102, file = "cmp.ts"},["5637"] = {line = 110, file = "cmp.ts"},["5638"] = {line = 111, file = "cmp.ts"},["5639"] = {line = 98, file = "cmp.ts"},["5640"] = {line = 67, file = "cmp.ts"},["5641"] = {line = 65, file = "cmp.ts"},["5642"] = {line = 62, file = "cmp.ts"},["5643"] = {line = 120, file = "cmp.ts"},["5650"] = {line = 2, file = "ts-context-commentstring.ts"},["5651"] = {line = 2, file = "ts-context-commentstring.ts"},["5652"] = {line = 4, file = "ts-context-commentstring.ts"},["5653"] = {line = 10, file = "ts-context-commentstring.ts"},["5654"] = {line = 4, file = "ts-context-commentstring.ts"},["5655"] = {line = 13, file = "ts-context-commentstring.ts"},["5656"] = {line = 14, file = "ts-context-commentstring.ts"},["5657"] = {line = 15, file = "ts-context-commentstring.ts"},["5658"] = {line = 16, file = "ts-context-commentstring.ts"},["5659"] = {line = 17, file = "ts-context-commentstring.ts"},["5660"] = {line = 16, file = "ts-context-commentstring.ts"},["5661"] = {line = 13, file = "ts-context-commentstring.ts"},["5662"] = {line = 22, file = "ts-context-commentstring.ts"},["5669"] = {line = 2, file = "comment.ts"},["5670"] = {line = 2, file = "comment.ts"},["5671"] = {line = 5, file = "comment.ts"},["5672"] = {line = 6, file = "comment.ts"},["5673"] = {line = 5, file = "comment.ts"},["5674"] = {line = 11, file = "comment.ts"},["5675"] = {line = 12, file = "comment.ts"},["5676"] = {line = 13, file = "comment.ts"},["5677"] = {line = 14, file = "comment.ts"},["5678"] = {line = 15, file = "comment.ts"},["5679"] = {line = 14, file = "comment.ts"},["5680"] = {line = 11, file = "comment.ts"},["5681"] = {line = 20, file = "comment.ts"},["5688"] = {line = 3, file = "copilot-lualine.ts"},["5689"] = {line = 6, file = "copilot-lualine.ts"},["5696"] = {line = 2, file = "copilot.ts"},["5697"] = {line = 2, file = "copilot.ts"},["5698"] = {line = 4, file = "copilot.ts"},["5699"] = {line = 4, file = "copilot.ts"},["5700"] = {line = 5, file = "copilot.ts"},["5701"] = {line = 5, file = "copilot.ts"},["5702"] = {line = 53, file = "copilot.ts"},["5703"] = {line = 54, file = "copilot.ts"},["5704"] = {line = 55, file = "copilot.ts"},["5705"] = {line = 53, file = "copilot.ts"},["5706"] = {line = 58, file = "copilot.ts"},["5707"] = {line = 59, file = "copilot.ts"},["5708"] = {line = 62, file = "copilot.ts"},["5709"] = {line = 63, file = "copilot.ts"},["5710"] = {line = 64, file = "copilot.ts"},["5711"] = {line = 65, file = "copilot.ts"},["5712"] = {line = 74, file = "copilot.ts"},["5713"] = {line = 74, file = "copilot.ts"},["5714"] = {line = 75, file = "copilot.ts"},["5715"] = {line = 76, file = "copilot.ts"},["5717"] = {line = 81, file = "copilot.ts"},["5720"] = {line = 86, file = "copilot.ts"},["5721"] = {line = 64, file = "copilot.ts"},["5722"] = {line = 58, file = "copilot.ts"},["5723"] = {line = 102, file = "copilot.ts"},["5730"] = {line = 2, file = "crates.ts"},["5731"] = {line = 2, file = "crates.ts"},["5732"] = {line = 3, file = "crates.ts"},["5733"] = {line = 3, file = "crates.ts"},["5734"] = {line = 5, file = "crates.ts"},["5735"] = {line = 10, file = "crates.ts"},["5736"] = {line = 5, file = "crates.ts"},["5737"] = {line = 15, file = "crates.ts"},["5738"] = {line = 15, file = "crates.ts"},["5739"] = {line = 15, file = "crates.ts"},["5740"] = {line = 15, file = "crates.ts"},["5741"] = {line = 15, file = "crates.ts"},["5743"] = {line = 15, file = "crates.ts"},["5745"] = {line = 13, file = "crates.ts"},["5746"] = {line = 14, file = "crates.ts"},["5747"] = {line = 15, file = "crates.ts"},["5748"] = {line = 16, file = "crates.ts"},["5749"] = {line = 17, file = "crates.ts"},["5750"] = {line = 18, file = "crates.ts"},["5751"] = {line = 17, file = "crates.ts"},["5752"] = {line = 13, file = "crates.ts"},["5753"] = {line = 21, file = "crates.ts"},["5760"] = {line = 2, file = "dap-virtual-text.ts"},["5761"] = {line = 2, file = "dap-virtual-text.ts"},["5762"] = {line = 4, file = "dap-virtual-text.ts"},["5763"] = {line = 9, file = "dap-virtual-text.ts"},["5764"] = {line = 4, file = "dap-virtual-text.ts"},["5765"] = {line = 12, file = "dap-virtual-text.ts"},["5766"] = {line = 13, file = "dap-virtual-text.ts"},["5767"] = {line = 14, file = "dap-virtual-text.ts"},["5768"] = {line = 15, file = "dap-virtual-text.ts"},["5769"] = {line = 16, file = "dap-virtual-text.ts"},["5770"] = {line = 15, file = "dap-virtual-text.ts"},["5771"] = {line = 12, file = "dap-virtual-text.ts"},["5772"] = {line = 19, file = "dap-virtual-text.ts"},["5779"] = {line = 2, file = "dbee.ts"},["5780"] = {line = 2, file = "dbee.ts"},["5781"] = {line = 4, file = "dbee.ts"},["5782"] = {line = 9, file = "dbee.ts"},["5783"] = {line = 4, file = "dbee.ts"},["5784"] = {line = 12, file = "dbee.ts"},["5785"] = {line = 13, file = "dbee.ts"},["5786"] = {line = 14, file = "dbee.ts"},["5787"] = {line = 15, file = "dbee.ts"},["5788"] = {line = 16, file = "dbee.ts"},["5789"] = {line = 15, file = "dbee.ts"},["5790"] = {line = 18, file = "dbee.ts"},["5791"] = {line = 19, file = "dbee.ts"},["5792"] = {line = 18, file = "dbee.ts"},["5793"] = {line = 12, file = "dbee.ts"},["5794"] = {line = 22, file = "dbee.ts"},["5801"] = {line = 3, file = "diffview.ts"},["5802"] = {line = 7, file = "diffview.ts"},["5809"] = {line = 3, file = "dropbar.ts"},["5810"] = {line = 4, file = "dropbar.ts"},["5811"] = {line = 5, file = "dropbar.ts"},["5812"] = {line = 6, file = "dropbar.ts"},["5813"] = {line = 7, file = "dropbar.ts"},["5814"] = {line = 8, file = "dropbar.ts"},["5815"] = {line = 9, file = "dropbar.ts"},["5816"] = {line = 5, file = "dropbar.ts"},["5817"] = {line = 3, file = "dropbar.ts"},["5818"] = {line = 12, file = "dropbar.ts"},["5825"] = {line = 2, file = "fidget.ts"},["5826"] = {line = 2, file = "fidget.ts"},["5827"] = {line = 4, file = "fidget.ts"},["5828"] = {line = 9, file = "fidget.ts"},["5829"] = {line = 4, file = "fidget.ts"},["5830"] = {line = 12, file = "fidget.ts"},["5831"] = {line = 19, file = "fidget.ts"},["5838"] = {line = 3, file = "firenvim.ts"},["5839"] = {line = 7, file = "firenvim.ts"},["5846"] = {line = 3, file = "flatten.ts"},["5847"] = {line = 9, file = "flatten.ts"},["5854"] = {line = 31, file = "floatterm.ts"},["5855"] = {line = 32, file = "floatterm.ts"},["5856"] = {line = 31, file = "floatterm.ts"},["5857"] = {line = 35, file = "floatterm.ts"},["5858"] = {line = 40, file = "floatterm.ts"},["5859"] = {line = 41, file = "floatterm.ts"},["5860"] = {line = 42, file = "floatterm.ts"},["5861"] = {line = 43, file = "floatterm.ts"},["5862"] = {line = 44, file = "floatterm.ts"},["5863"] = {line = 45, file = "floatterm.ts"},["5864"] = {line = 47, file = "floatterm.ts"},["5871"] = {line = 3, file = "git-browse.ts"},["5872"] = {line = 6, file = "git-browse.ts"},["5879"] = {line = 2, file = "glance.ts"},["5880"] = {line = 2, file = "glance.ts"},["5881"] = {line = 4, file = "glance.ts"},["5882"] = {line = 5, file = "glance.ts"},["5883"] = {line = 6, file = "glance.ts"},["5884"] = {line = 7, file = "glance.ts"},["5885"] = {line = 6, file = "glance.ts"},["5886"] = {line = 4, file = "glance.ts"},["5887"] = {line = 10, file = "glance.ts"},["5894"] = {line = 4, file = "goto-preview.ts"},["5895"] = {line = 12, file = "goto-preview.ts"},["5902"] = {line = 2, file = "hex.ts"},["5903"] = {line = 2, file = "hex.ts"},["5904"] = {line = 4, file = "hex.ts"},["5905"] = {line = 9, file = "hex.ts"},["5906"] = {line = 4, file = "hex.ts"},["5907"] = {line = 12, file = "hex.ts"},["5908"] = {line = 13, file = "hex.ts"},["5909"] = {line = 14, file = "hex.ts"},["5910"] = {line = 15, file = "hex.ts"},["5911"] = {line = 16, file = "hex.ts"},["5912"] = {line = 17, file = "hex.ts"},["5913"] = {line = 18, file = "hex.ts"},["5916"] = {line = 21, file = "hex.ts"},["5917"] = {line = 16, file = "hex.ts"},["5918"] = {line = 12, file = "hex.ts"},["5919"] = {line = 24, file = "hex.ts"},["5926"] = {line = 2, file = "hlchunk.ts"},["5927"] = {line = 2, file = "hlchunk.ts"},["5928"] = {line = 4, file = "hlchunk.ts"},["5929"] = {line = 9, file = "hlchunk.ts"},["5930"] = {line = 4, file = "hlchunk.ts"},["5931"] = {line = 12, file = "hlchunk.ts"},["5932"] = {line = 13, file = "hlchunk.ts"},["5933"] = {line = 14, file = "hlchunk.ts"},["5934"] = {line = 15, file = "hlchunk.ts"},["5935"] = {line = 16, file = "hlchunk.ts"},["5936"] = {line = 15, file = "hlchunk.ts"},["5937"] = {line = 12, file = "hlchunk.ts"},["5938"] = {line = 23, file = "hlchunk.ts"},["5945"] = {line = 2, file = "icon-picker.ts"},["5946"] = {line = 2, file = "icon-picker.ts"},["5947"] = {line = 4, file = "icon-picker.ts"},["5948"] = {line = 9, file = "icon-picker.ts"},["5949"] = {line = 4, file = "icon-picker.ts"},["5950"] = {line = 12, file = "icon-picker.ts"},["5951"] = {line = 13, file = "icon-picker.ts"},["5952"] = {line = 14, file = "icon-picker.ts"},["5953"] = {line = 15, file = "icon-picker.ts"},["5954"] = {line = 16, file = "icon-picker.ts"},["5955"] = {line = 15, file = "icon-picker.ts"},["5956"] = {line = 12, file = "icon-picker.ts"},["5957"] = {line = 21, file = "icon-picker.ts"},["5964"] = {line = 2, file = "illuminate.ts"},["5965"] = {line = 2, file = "illuminate.ts"},["5966"] = {line = 4, file = "illuminate.ts"},["5967"] = {line = 9, file = "illuminate.ts"},["5968"] = {line = 4, file = "illuminate.ts"},["5969"] = {line = 12, file = "illuminate.ts"},["5970"] = {line = 13, file = "illuminate.ts"},["5971"] = {line = 14, file = "illuminate.ts"},["5972"] = {line = 15, file = "illuminate.ts"},["5973"] = {line = 16, file = "illuminate.ts"},["5974"] = {line = 15, file = "illuminate.ts"},["5975"] = {line = 12, file = "illuminate.ts"},["5976"] = {line = 21, file = "illuminate.ts"},["5983"] = {line = 2, file = "indent-blankline.ts"},["5984"] = {line = 2, file = "indent-blankline.ts"},["5985"] = {line = 3, file = "indent-blankline.ts"},["5986"] = {line = 3, file = "indent-blankline.ts"},["5987"] = {line = 5, file = "indent-blankline.ts"},["5988"] = {line = 6, file = "indent-blankline.ts"},["5989"] = {line = 7, file = "indent-blankline.ts"},["5990"] = {line = 8, file = "indent-blankline.ts"},["5991"] = {line = 9, file = "indent-blankline.ts"},["5992"] = {line = 12, file = "indent-blankline.ts"},["5993"] = {line = 14, file = "indent-blankline.ts"},["5994"] = {line = 14, file = "indent-blankline.ts"},["5995"] = {line = 14, file = "indent-blankline.ts"},["5996"] = {line = 14, file = "indent-blankline.ts"},["5998"] = {line = 14, file = "indent-blankline.ts"},["6000"] = {line = 12, file = "indent-blankline.ts"},["6001"] = {line = 8, file = "indent-blankline.ts"},["6002"] = {line = 5, file = "indent-blankline.ts"},["6003"] = {line = 19, file = "indent-blankline.ts"},["6010"] = {line = 3, file = "kanagawa.ts"},["6011"] = {line = 15, file = "kanagawa.ts"},["6018"] = {line = 3, file = "lazygit.ts"},["6019"] = {line = 6, file = "lazygit.ts"},["6020"] = {line = 7, file = "lazygit.ts"},["6021"] = {line = 8, file = "lazygit.ts"},["6022"] = {line = 9, file = "lazygit.ts"},["6023"] = {line = 10, file = "lazygit.ts"},["6024"] = {line = 5, file = "lazygit.ts"},["6025"] = {line = 20, file = "lazygit.ts"},["6032"] = {line = 2, file = "leap.ts"},["6033"] = {line = 2, file = "leap.ts"},["6034"] = {line = 3, file = "leap.ts"},["6035"] = {line = 3, file = "leap.ts"},["6036"] = {line = 5, file = "leap.ts"},["6037"] = {line = 6, file = "leap.ts"},["6038"] = {line = 5, file = "leap.ts"},["6039"] = {line = 11, file = "leap.ts"},["6040"] = {line = 12, file = "leap.ts"},["6041"] = {line = 13, file = "leap.ts"},["6042"] = {line = 14, file = "leap.ts"},["6043"] = {line = 15, file = "leap.ts"},["6044"] = {line = 16, file = "leap.ts"},["6045"] = {line = 17, file = "leap.ts"},["6047"] = {line = 19, file = "leap.ts"},["6048"] = {line = 20, file = "leap.ts"},["6049"] = {line = 21, file = "leap.ts"},["6051"] = {line = 23, file = "leap.ts"},["6052"] = {line = 14, file = "leap.ts"},["6053"] = {line = 11, file = "leap.ts"},["6054"] = {line = 26, file = "leap.ts"},["6061"] = {line = 2, file = "lightbulb.ts"},["6062"] = {line = 2, file = "lightbulb.ts"},["6063"] = {line = 4, file = "lightbulb.ts"},["6064"] = {line = 9, file = "lightbulb.ts"},["6065"] = {line = 4, file = "lightbulb.ts"},["6066"] = {line = 12, file = "lightbulb.ts"},["6067"] = {line = 13, file = "lightbulb.ts"},["6068"] = {line = 14, file = "lightbulb.ts"},["6069"] = {line = 15, file = "lightbulb.ts"},["6070"] = {line = 16, file = "lightbulb.ts"},["6071"] = {line = 15, file = "lightbulb.ts"},["6072"] = {line = 12, file = "lightbulb.ts"},["6073"] = {line = 23, file = "lightbulb.ts"},["6080"] = {line = 2, file = "lspUI.ts"},["6081"] = {line = 2, file = "lspUI.ts"},["6082"] = {line = 4, file = "lspUI.ts"},["6083"] = {line = 5, file = "lspUI.ts"},["6084"] = {line = 6, file = "lspUI.ts"},["6085"] = {line = 7, file = "lspUI.ts"},["6086"] = {line = 8, file = "lspUI.ts"},["6087"] = {line = 9, file = "lspUI.ts"},["6088"] = {line = 10, file = "lspUI.ts"},["6089"] = {line = 8, file = "lspUI.ts"},["6090"] = {line = 4, file = "lspUI.ts"},["6091"] = {line = 17, file = "lspUI.ts"},["6098"] = {line = 2, file = "lsp_lines.ts"},["6099"] = {line = 2, file = "lsp_lines.ts"},["6100"] = {line = 4, file = "lsp_lines.ts"},["6101"] = {line = 5, file = "lsp_lines.ts"},["6102"] = {line = 6, file = "lsp_lines.ts"},["6103"] = {line = 7, file = "lsp_lines.ts"},["6104"] = {line = 8, file = "lsp_lines.ts"},["6105"] = {line = 7, file = "lsp_lines.ts"},["6106"] = {line = 4, file = "lsp_lines.ts"},["6107"] = {line = 11, file = "lsp_lines.ts"},["6114"] = {line = 2, file = "lsp_signature.ts"},["6115"] = {line = 2, file = "lsp_signature.ts"},["6116"] = {line = 4, file = "lsp_signature.ts"},["6117"] = {line = 5, file = "lsp_signature.ts"},["6118"] = {line = 6, file = "lsp_signature.ts"},["6119"] = {line = 7, file = "lsp_signature.ts"},["6120"] = {line = 8, file = "lsp_signature.ts"},["6121"] = {line = 9, file = "lsp_signature.ts"},["6122"] = {line = 7, file = "lsp_signature.ts"},["6123"] = {line = 4, file = "lsp_signature.ts"},["6124"] = {line = 14, file = "lsp_signature.ts"},["6131"] = {line = 2, file = "navic.ts"},["6132"] = {line = 2, file = "navic.ts"},["6133"] = {line = 3, file = "navic.ts"},["6134"] = {line = 3, file = "navic.ts"},["6135"] = {line = 4, file = "navic.ts"},["6136"] = {line = 4, file = "navic.ts"},["6137"] = {line = 6, file = "navic.ts"},["6138"] = {line = 13, file = "navic.ts"},["6139"] = {line = 13, file = "navic.ts"},["6140"] = {line = 14, file = "navic.ts"},["6142"] = {line = 17, file = "navic.ts"},["6144"] = {line = 6, file = "navic.ts"},["6145"] = {line = 21, file = "navic.ts"},["6146"] = {line = 21, file = "navic.ts"},["6147"] = {line = 21, file = "navic.ts"},["6148"] = {line = 22, file = "navic.ts"},["6149"] = {line = 23, file = "navic.ts"},["6150"] = {line = 24, file = "navic.ts"},["6151"] = {line = 25, file = "navic.ts"},["6152"] = {line = 26, file = "navic.ts"},["6155"] = {line = 21, file = "navic.ts"},["6156"] = {line = 21, file = "navic.ts"},["6157"] = {line = 31, file = "navic.ts"},["6158"] = {line = 32, file = "navic.ts"},["6159"] = {line = 33, file = "navic.ts"},["6160"] = {line = 34, file = "navic.ts"},["6161"] = {line = 35, file = "navic.ts"},["6162"] = {line = 34, file = "navic.ts"},["6163"] = {line = 31, file = "navic.ts"},["6164"] = {line = 38, file = "navic.ts"},["6177"] = {line = 44, file = "lspconfig.ts"},["6178"] = {line = 2, file = "lspconfig.ts"},["6179"] = {line = 2, file = "lspconfig.ts"},["6180"] = {line = 3, file = "lspconfig.ts"},["6181"] = {line = 3, file = "lspconfig.ts"},["6182"] = {line = 4, file = "lspconfig.ts"},["6183"] = {line = 4, file = "lspconfig.ts"},["6184"] = {line = 44, file = "lspconfig.ts"},["6185"] = {line = 45, file = "lspconfig.ts"},["6186"] = {line = 46, file = "lspconfig.ts"},["6187"] = {line = 47, file = "lspconfig.ts"},["6188"] = {line = 49, file = "lspconfig.ts"},["6190"] = {line = 68, file = "lspconfig.ts"},["6191"] = {line = 69, file = "lspconfig.ts"},["6192"] = {line = 70, file = "lspconfig.ts"},["6193"] = {line = 71, file = "lspconfig.ts"},["6196"] = {line = 87, file = "lspconfig.ts"},["6199"] = {line = 73, file = "lspconfig.ts"},["6200"] = {line = 74, file = "lspconfig.ts"},["6201"] = {line = 75, file = "lspconfig.ts"},["6203"] = {line = 80, file = "lspconfig.ts"},["6205"] = {line = 82, file = "lspconfig.ts"},["6207"] = {line = 84, file = "lspconfig.ts"},["6214"] = {line = 72, file = "lspconfig.ts"},["6217"] = {line = 89, file = "lspconfig.ts"},["6219"] = {line = 92, file = "lspconfig.ts"},["6220"] = {line = 93, file = "lspconfig.ts"},["6223"] = {line = 120, file = "lspconfig.ts"},["6224"] = {line = 121, file = "lspconfig.ts"},["6225"] = {line = 122, file = "lspconfig.ts"},["6226"] = {line = 120, file = "lspconfig.ts"},["6227"] = {line = 133, file = "lspconfig.ts"},["6228"] = {line = 134, file = "lspconfig.ts"},["6229"] = {line = 139, file = "lspconfig.ts"},["6230"] = {line = 140, file = "lspconfig.ts"},["6231"] = {line = 141, file = "lspconfig.ts"},["6232"] = {line = 142, file = "lspconfig.ts"},["6233"] = {line = 143, file = "lspconfig.ts"},["6234"] = {line = 144, file = "lspconfig.ts"},["6235"] = {line = 145, file = "lspconfig.ts"},["6236"] = {line = 146, file = "lspconfig.ts"},["6237"] = {line = 149, file = "lspconfig.ts"},["6238"] = {line = 150, file = "lspconfig.ts"},["6239"] = {line = 151, file = "lspconfig.ts"},["6240"] = {line = 152, file = "lspconfig.ts"},["6241"] = {line = 153, file = "lspconfig.ts"},["6242"] = {line = 154, file = "lspconfig.ts"},["6243"] = {line = 155, file = "lspconfig.ts"},["6244"] = {line = 148, file = "lspconfig.ts"},["6245"] = {line = 161, file = "lspconfig.ts"},["6246"] = {line = 162, file = "lspconfig.ts"},["6247"] = {line = 163, file = "lspconfig.ts"},["6248"] = {line = 164, file = "lspconfig.ts"},["6249"] = {line = 165, file = "lspconfig.ts"},["6250"] = {line = 166, file = "lspconfig.ts"},["6251"] = {line = 167, file = "lspconfig.ts"},["6252"] = {line = 160, file = "lspconfig.ts"},["6253"] = {line = 143, file = "lspconfig.ts"},["6254"] = {line = 139, file = "lspconfig.ts"},["6255"] = {line = 173, file = "lspconfig.ts"},["6256"] = {line = 174, file = "lspconfig.ts"},["6257"] = {line = 175, file = "lspconfig.ts"},["6258"] = {line = 176, file = "lspconfig.ts"},["6259"] = {line = 173, file = "lspconfig.ts"},["6260"] = {line = 179, file = "lspconfig.ts"},["6261"] = {line = 182, file = "lspconfig.ts"},["6262"] = {line = 185, file = "lspconfig.ts"},["6263"] = {line = 188, file = "lspconfig.ts"},["6264"] = {line = 192, file = "lspconfig.ts"},["6265"] = {line = 195, file = "lspconfig.ts"},["6266"] = {line = 198, file = "lspconfig.ts"},["6267"] = {line = 201, file = "lspconfig.ts"},["6268"] = {line = 139, file = "lspconfig.ts"},["6269"] = {line = 206, file = "lspconfig.ts"},["6270"] = {line = 206, file = "lspconfig.ts"},["6271"] = {line = 206, file = "lspconfig.ts"},["6272"] = {line = 206, file = "lspconfig.ts"},["6274"] = {line = 221, file = "lspconfig.ts"},["6276"] = {line = 222, file = "lspconfig.ts"},["6277"] = {line = 222, file = "lspconfig.ts"},["6278"] = {line = 222, file = "lspconfig.ts"},["6279"] = {line = 222, file = "lspconfig.ts"},["6280"] = {line = 223, file = "lspconfig.ts"},["6281"] = {line = 224, file = "lspconfig.ts"},["6282"] = {line = 225, file = "lspconfig.ts"},["6284"] = {line = 226, file = "lspconfig.ts"},["6285"] = {line = 226, file = "lspconfig.ts"},["6286"] = {line = 227, file = "lspconfig.ts"},["6288"] = {line = 229, file = "lspconfig.ts"},["6289"] = {line = 231, file = "lspconfig.ts"},["6290"] = {line = 232, file = "lspconfig.ts"},["6292"] = {line = 237, file = "lspconfig.ts"},["6293"] = {line = 238, file = "lspconfig.ts"},["6294"] = {line = 239, file = "lspconfig.ts"},["6295"] = {line = 240, file = "lspconfig.ts"},["6298"] = {line = 243, file = "lspconfig.ts"},["6299"] = {line = 244, file = "lspconfig.ts"},["6300"] = {line = 244, file = "lspconfig.ts"},["6301"] = {line = 245, file = "lspconfig.ts"},["6302"] = {line = 246, file = "lspconfig.ts"},["6304"] = {line = 252, file = "lspconfig.ts"},["6305"] = {line = 252, file = "lspconfig.ts"},["6306"] = {line = 252, file = "lspconfig.ts"},["6308"] = {line = 251, file = "lspconfig.ts"},["6309"] = {line = 257, file = "lspconfig.ts"},["6310"] = {line = 258, file = "lspconfig.ts"},["6312"] = {line = 260, file = "lspconfig.ts"},["6317"] = {line = 263, file = "lspconfig.ts"},["6320"] = {line = 7, file = "lspconfig.ts"},["6321"] = {line = 55, file = "lspconfig.ts"},["6322"] = {line = 56, file = "lspconfig.ts"},["6323"] = {line = 58, file = "lspconfig.ts"},["6324"] = {line = 59, file = "lspconfig.ts"},["6325"] = {line = 60, file = "lspconfig.ts"},["6326"] = {line = 58, file = "lspconfig.ts"},["6327"] = {line = 63, file = "lspconfig.ts"},["6328"] = {line = 64, file = "lspconfig.ts"},["6329"] = {line = 65, file = "lspconfig.ts"},["6330"] = {line = 63, file = "lspconfig.ts"},["6332"] = {line = 98, file = "lspconfig.ts"},["6333"] = {line = 99, file = "lspconfig.ts"},["6334"] = {line = 100, file = "lspconfig.ts"},["6335"] = {line = 101, file = "lspconfig.ts"},["6336"] = {line = 101, file = "lspconfig.ts"},["6337"] = {line = 101, file = "lspconfig.ts"},["6338"] = {line = 103, file = "lspconfig.ts"},["6339"] = {line = 104, file = "lspconfig.ts"},["6341"] = {line = 102, file = "lspconfig.ts"},["6342"] = {line = 101, file = "lspconfig.ts"},["6344"] = {line = 110, file = "lspconfig.ts"},["6345"] = {line = 110, file = "lspconfig.ts"},["6346"] = {line = 110, file = "lspconfig.ts"},["6347"] = {line = 112, file = "lspconfig.ts"},["6348"] = {line = 113, file = "lspconfig.ts"},["6350"] = {line = 111, file = "lspconfig.ts"},["6351"] = {line = 110, file = "lspconfig.ts"},["6354"] = {line = 125, file = "lspconfig.ts"},["6355"] = {line = 126, file = "lspconfig.ts"},["6356"] = {line = 128, file = "lspconfig.ts"},["6357"] = {line = 125, file = "lspconfig.ts"},["6358"] = {line = 209, file = "lspconfig.ts"},["6359"] = {line = 209, file = "lspconfig.ts"},["6360"] = {line = 209, file = "lspconfig.ts"},["6361"] = {line = 217, file = "lspconfig.ts"},["6362"] = {line = 210, file = "lspconfig.ts"},["6363"] = {line = 209, file = "lspconfig.ts"},["6364"] = {line = 277, file = "lspconfig.ts"},["6371"] = {line = 2, file = "lualine.ts"},["6372"] = {line = 2, file = "lualine.ts"},["6373"] = {line = 3, file = "lualine.ts"},["6374"] = {line = 3, file = "lualine.ts"},["6375"] = {line = 4, file = "lualine.ts"},["6376"] = {line = 4, file = "lualine.ts"},["6377"] = {line = 4, file = "lualine.ts"},["6378"] = {line = 5, file = "lualine.ts"},["6379"] = {line = 5, file = "lualine.ts"},["6380"] = {line = 7, file = "lualine.ts"},["6381"] = {line = 8, file = "lualine.ts"},["6382"] = {line = 9, file = "lualine.ts"},["6383"] = {line = 10, file = "lualine.ts"},["6384"] = {line = 11, file = "lualine.ts"},["6385"] = {line = 24, file = "lualine.ts"},["6386"] = {line = 25, file = "lualine.ts"},["6387"] = {line = 26, file = "lualine.ts"},["6388"] = {line = 27, file = "lualine.ts"},["6389"] = {line = 24, file = "lualine.ts"},["6390"] = {line = 29, file = "lualine.ts"},["6391"] = {line = 30, file = "lualine.ts"},["6392"] = {line = 31, file = "lualine.ts"},["6393"] = {line = 33, file = "lualine.ts"},["6394"] = {line = 34, file = "lualine.ts"},["6395"] = {line = 29, file = "lualine.ts"},["6396"] = {line = 38, file = "lualine.ts"},["6397"] = {line = 39, file = "lualine.ts"},["6398"] = {line = 40, file = "lualine.ts"},["6399"] = {line = 41, file = "lualine.ts"},["6400"] = {line = 42, file = "lualine.ts"},["6401"] = {line = 40, file = "lualine.ts"},["6402"] = {line = 46, file = "lualine.ts"},["6403"] = {line = 47, file = "lualine.ts"},["6404"] = {line = 47, file = "lualine.ts"},["6405"] = {line = 47, file = "lualine.ts"},["6406"] = {line = 47, file = "lualine.ts"},["6407"] = {line = 47, file = "lualine.ts"},["6408"] = {line = 48, file = "lualine.ts"},["6409"] = {line = 51, file = "lualine.ts"},["6410"] = {line = 46, file = "lualine.ts"},["6411"] = {line = 39, file = "lualine.ts"},["6413"] = {line = 56, file = "lualine.ts"},["6414"] = {line = 57, file = "lualine.ts"},["6415"] = {line = 58, file = "lualine.ts"},["6416"] = {line = 58, file = "lualine.ts"},["6417"] = {line = 59, file = "lualine.ts"},["6418"] = {line = 60, file = "lualine.ts"},["6420"] = {line = 63, file = "lualine.ts"},["6422"] = {line = 58, file = "lualine.ts"},["6425"] = {line = 68, file = "lualine.ts"},["6426"] = {line = 68, file = "lualine.ts"},["6427"] = {line = 69, file = "lualine.ts"},["6428"] = {line = 69, file = "lualine.ts"},["6429"] = {line = 70, file = "lualine.ts"},["6430"] = {line = 70, file = "lualine.ts"},["6433"] = {line = 73, file = "lualine.ts"},["6434"] = {line = 38, file = "lualine.ts"},["6435"] = {line = 76, file = "lualine.ts"},["6436"] = {line = 77, file = "lualine.ts"},["6437"] = {line = 76, file = "lualine.ts"},["6438"] = {line = 79, file = "lualine.ts"},["6439"] = {line = 10, file = "lualine.ts"},["6440"] = {line = 7, file = "lualine.ts"},["6441"] = {line = 82, file = "lualine.ts"},["6448"] = {line = 3, file = "markdown-preview.ts"},["6449"] = {line = 4, file = "markdown-preview.ts"},["6450"] = {line = 5, file = "markdown-preview.ts"},["6451"] = {line = 6, file = "markdown-preview.ts"},["6452"] = {line = 7, file = "markdown-preview.ts"},["6453"] = {line = 8, file = "markdown-preview.ts"},["6454"] = {line = 7, file = "markdown-preview.ts"},["6455"] = {line = 10, file = "markdown-preview.ts"},["6456"] = {line = 3, file = "markdown-preview.ts"},["6457"] = {line = 12, file = "markdown-preview.ts"},["6464"] = {line = 2, file = "marks.ts"},["6465"] = {line = 2, file = "marks.ts"},["6466"] = {line = 4, file = "marks.ts"},["6467"] = {line = 5, file = "marks.ts"},["6468"] = {line = 6, file = "marks.ts"},["6469"] = {line = 7, file = "marks.ts"},["6470"] = {line = 8, file = "marks.ts"},["6471"] = {line = 6, file = "marks.ts"},["6472"] = {line = 4, file = "marks.ts"},["6473"] = {line = 11, file = "marks.ts"},["6480"] = {line = 3, file = "markview.ts"},["6481"] = {line = 8, file = "markview.ts"},["6488"] = {line = 2, file = "mason-nvim-dap.ts"},["6489"] = {line = 2, file = "mason-nvim-dap.ts"},["6490"] = {line = 4, file = "mason-nvim-dap.ts"},["6491"] = {line = 10, file = "mason-nvim-dap.ts"},["6492"] = {line = 4, file = "mason-nvim-dap.ts"},["6493"] = {line = 13, file = "mason-nvim-dap.ts"},["6494"] = {line = 14, file = "mason-nvim-dap.ts"},["6495"] = {line = 15, file = "mason-nvim-dap.ts"},["6496"] = {line = 16, file = "mason-nvim-dap.ts"},["6497"] = {line = 17, file = "mason-nvim-dap.ts"},["6498"] = {line = 18, file = "mason-nvim-dap.ts"},["6499"] = {line = 18, file = "mason-nvim-dap.ts"},["6500"] = {line = 18, file = "mason-nvim-dap.ts"},["6501"] = {line = 18, file = "mason-nvim-dap.ts"},["6502"] = {line = 18, file = "mason-nvim-dap.ts"},["6503"] = {line = 18, file = "mason-nvim-dap.ts"},["6504"] = {line = 18, file = "mason-nvim-dap.ts"},["6505"] = {line = 17, file = "mason-nvim-dap.ts"},["6506"] = {line = 13, file = "mason-nvim-dap.ts"},["6507"] = {line = 21, file = "mason-nvim-dap.ts"},["6514"] = {line = 2, file = "mason.ts"},["6515"] = {line = 2, file = "mason.ts"},["6516"] = {line = 4, file = "mason.ts"},["6517"] = {line = 5, file = "mason.ts"},["6518"] = {line = 6, file = "mason.ts"},["6519"] = {line = 7, file = "mason.ts"},["6520"] = {line = 6, file = "mason.ts"},["6521"] = {line = 4, file = "mason.ts"},["6522"] = {line = 10, file = "mason.ts"},["6529"] = {line = 3, file = "midnight.ts"},["6530"] = {line = 8, file = "midnight.ts"},["6537"] = {line = 1, file = "module-load-test.ts"},["6538"] = {line = 2, file = "module-load-test.ts"},["6539"] = {line = 1, file = "module-load-test.ts"},["6540"] = {line = 6, file = "module-load-test.ts"},["6547"] = {line = 3, file = "neogen.ts"},["6548"] = {line = 7, file = "neogen.ts"},["6555"] = {line = 3, file = "neotest.ts"},["6556"] = {line = 3, file = "neotest.ts"},["6557"] = {line = 5, file = "neotest.ts"},["6558"] = {line = 9, file = "neotest.ts"},["6559"] = {line = 5, file = "neotest.ts"},["6560"] = {line = 12, file = "neotest.ts"},["6561"] = {line = 21, file = "neotest.ts"},["6568"] = {line = 2, file = "noice.ts"},["6569"] = {line = 2, file = "noice.ts"},["6570"] = {line = 4, file = "noice.ts"},["6571"] = {line = 8, file = "noice.ts"},["6572"] = {line = 9, file = "noice.ts"},["6573"] = {line = 4, file = "noice.ts"},["6574"] = {line = 12, file = "noice.ts"},["6575"] = {line = 13, file = "noice.ts"},["6576"] = {line = 14, file = "noice.ts"},["6577"] = {line = 15, file = "noice.ts"},["6578"] = {line = 19, file = "noice.ts"},["6579"] = {line = 20, file = "noice.ts"},["6581"] = {line = 24, file = "noice.ts"},["6582"] = {line = 25, file = "noice.ts"},["6584"] = {line = 19, file = "noice.ts"},["6585"] = {line = 12, file = "noice.ts"},["6586"] = {line = 29, file = "noice.ts"},["6593"] = {line = 3, file = "nord.ts"},["6594"] = {line = 8, file = "nord.ts"},["6601"] = {line = 2, file = "nvim-notify.ts"},["6602"] = {line = 2, file = "nvim-notify.ts"},["6603"] = {line = 4, file = "nvim-notify.ts"},["6604"] = {line = 8, file = "nvim-notify.ts"},["6605"] = {line = 9, file = "nvim-notify.ts"},["6606"] = {line = 4, file = "nvim-notify.ts"},["6607"] = {line = 12, file = "nvim-notify.ts"},["6608"] = {line = 13, file = "nvim-notify.ts"},["6609"] = {line = 14, file = "nvim-notify.ts"},["6610"] = {line = 15, file = "nvim-notify.ts"},["6611"] = {line = 19, file = "nvim-notify.ts"},["6612"] = {line = 20, file = "nvim-notify.ts"},["6614"] = {line = 24, file = "nvim-notify.ts"},["6615"] = {line = 25, file = "nvim-notify.ts"},["6616"] = {line = 26, file = "nvim-notify.ts"},["6618"] = {line = 19, file = "nvim-notify.ts"},["6619"] = {line = 12, file = "nvim-notify.ts"},["6620"] = {line = 30, file = "nvim-notify.ts"},["6627"] = {line = 2, file = "nvim-tree-devicons.ts"},["6628"] = {line = 2, file = "nvim-tree-devicons.ts"},["6629"] = {line = 4, file = "nvim-tree-devicons.ts"},["6630"] = {line = 5, file = "nvim-tree-devicons.ts"},["6631"] = {line = 6, file = "nvim-tree-devicons.ts"},["6632"] = {line = 7, file = "nvim-tree-devicons.ts"},["6633"] = {line = 8, file = "nvim-tree-devicons.ts"},["6634"] = {line = 6, file = "nvim-tree-devicons.ts"},["6635"] = {line = 4, file = "nvim-tree-devicons.ts"},["6636"] = {line = 11, file = "nvim-tree-devicons.ts"},["6643"] = {line = 3, file = "nvim-tree.ts"},["6644"] = {line = 4, file = "nvim-tree.ts"},["6645"] = {line = 5, file = "nvim-tree.ts"},["6646"] = {line = 6, file = "nvim-tree.ts"},["6647"] = {line = 7, file = "nvim-tree.ts"},["6648"] = {line = 8, file = "nvim-tree.ts"},["6649"] = {line = 9, file = "nvim-tree.ts"},["6650"] = {line = 10, file = "nvim-tree.ts"},["6651"] = {line = 8, file = "nvim-tree.ts"},["6652"] = {line = 12, file = "nvim-tree.ts"},["6653"] = {line = 13, file = "nvim-tree.ts"},["6654"] = {line = 14, file = "nvim-tree.ts"},["6655"] = {line = 15, file = "nvim-tree.ts"},["6656"] = {line = 16, file = "nvim-tree.ts"},["6657"] = {line = 17, file = "nvim-tree.ts"},["6658"] = {line = 21, file = "nvim-tree.ts"},["6659"] = {line = 27, file = "nvim-tree.ts"},["6660"] = {line = 31, file = "nvim-tree.ts"},["6661"] = {line = 34, file = "nvim-tree.ts"},["6662"] = {line = 39, file = "nvim-tree.ts"},["6663"] = {line = 40, file = "nvim-tree.ts"},["6664"] = {line = 41, file = "nvim-tree.ts"},["6665"] = {line = 42, file = "nvim-tree.ts"},["6666"] = {line = 44, file = "nvim-tree.ts"},["6667"] = {line = 48, file = "nvim-tree.ts"},["6668"] = {line = 60, file = "nvim-tree.ts"},["6669"] = {line = 61, file = "nvim-tree.ts"},["6670"] = {line = 62, file = "nvim-tree.ts"},["6671"] = {line = 63, file = "nvim-tree.ts"},["6672"] = {line = 64, file = "nvim-tree.ts"},["6673"] = {line = 65, file = "nvim-tree.ts"},["6674"] = {line = 66, file = "nvim-tree.ts"},["6675"] = {line = 67, file = "nvim-tree.ts"},["6676"] = {line = 59, file = "nvim-tree.ts"},["6677"] = {line = 70, file = "nvim-tree.ts"},["6678"] = {line = 71, file = "nvim-tree.ts"},["6679"] = {line = 72, file = "nvim-tree.ts"},["6680"] = {line = 73, file = "nvim-tree.ts"},["6681"] = {line = 74, file = "nvim-tree.ts"},["6682"] = {line = 75, file = "nvim-tree.ts"},["6683"] = {line = 76, file = "nvim-tree.ts"},["6684"] = {line = 69, file = "nvim-tree.ts"},["6685"] = {line = 39, file = "nvim-tree.ts"},["6686"] = {line = 7, file = "nvim-tree.ts"},["6687"] = {line = 82, file = "nvim-tree.ts"},["6688"] = {line = 6, file = "nvim-tree.ts"},["6689"] = {line = 3, file = "nvim-tree.ts"},["6690"] = {line = 85, file = "nvim-tree.ts"},["6697"] = {line = 2, file = "obsidian.ts"},["6698"] = {line = 2, file = "obsidian.ts"},["6699"] = {line = 13, file = "obsidian.ts"},["6700"] = {line = 14, file = "obsidian.ts"},["6701"] = {line = 16, file = "obsidian.ts"},["6702"] = {line = 16, file = "obsidian.ts"},["6703"] = {line = 9, file = "obsidian.ts"},["6704"] = {line = 10, file = "obsidian.ts"},["6705"] = {line = 11, file = "obsidian.ts"},["6706"] = {line = 12, file = "obsidian.ts"},["6707"] = {line = 13, file = "obsidian.ts"},["6708"] = {line = 14, file = "obsidian.ts"},["6709"] = {line = 15, file = "obsidian.ts"},["6710"] = {line = 9, file = "obsidian.ts"},["6711"] = {line = 19, file = "obsidian.ts"},["6718"] = {line = 2, file = "octo.ts"},["6719"] = {line = 2, file = "octo.ts"},["6720"] = {line = 4, file = "octo.ts"},["6721"] = {line = 5, file = "octo.ts"},["6722"] = {line = 6, file = "octo.ts"},["6723"] = {line = 7, file = "octo.ts"},["6724"] = {line = 8, file = "octo.ts"},["6725"] = {line = 9, file = "octo.ts"},["6726"] = {line = 10, file = "octo.ts"},["6727"] = {line = 11, file = "octo.ts"},["6728"] = {line = 9, file = "octo.ts"},["6729"] = {line = 4, file = "octo.ts"},["6730"] = {line = 14, file = "octo.ts"},["6737"] = {line = 3, file = "outline.ts"},["6738"] = {line = 4, file = "outline.ts"},["6739"] = {line = 5, file = "outline.ts"},["6740"] = {line = 6, file = "outline.ts"},["6741"] = {line = 7, file = "outline.ts"},["6742"] = {line = 12, file = "outline.ts"},["6743"] = {line = 3, file = "outline.ts"},["6744"] = {line = 25, file = "outline.ts"},["6751"] = {line = 2, file = "overseer.ts"},["6752"] = {line = 2, file = "overseer.ts"},["6753"] = {line = 4, file = "overseer.ts"},["6754"] = {line = 8, file = "overseer.ts"},["6755"] = {line = 4, file = "overseer.ts"},["6756"] = {line = 11, file = "overseer.ts"},["6757"] = {line = 12, file = "overseer.ts"},["6758"] = {line = 13, file = "overseer.ts"},["6759"] = {line = 14, file = "overseer.ts"},["6760"] = {line = 15, file = "overseer.ts"},["6761"] = {line = 14, file = "overseer.ts"},["6762"] = {line = 11, file = "overseer.ts"},["6763"] = {line = 18, file = "overseer.ts"},["6770"] = {line = 2, file = "poimandres.ts"},["6771"] = {line = 2, file = "poimandres.ts"},["6772"] = {line = 4, file = "poimandres.ts"},["6773"] = {line = 5, file = "poimandres.ts"},["6774"] = {line = 6, file = "poimandres.ts"},["6775"] = {line = 7, file = "poimandres.ts"},["6776"] = {line = 8, file = "poimandres.ts"},["6777"] = {line = 9, file = "poimandres.ts"},["6778"] = {line = 8, file = "poimandres.ts"},["6779"] = {line = 4, file = "poimandres.ts"},["6780"] = {line = 12, file = "poimandres.ts"},["6787"] = {line = 2, file = "presence.ts"},["6788"] = {line = 2, file = "presence.ts"},["6789"] = {line = 4, file = "presence.ts"},["6790"] = {line = 5, file = "presence.ts"},["6791"] = {line = 4, file = "presence.ts"},["6792"] = {line = 10, file = "presence.ts"},["6793"] = {line = 11, file = "presence.ts"},["6794"] = {line = 12, file = "presence.ts"},["6795"] = {line = 13, file = "presence.ts"},["6796"] = {line = 12, file = "presence.ts"},["6797"] = {line = 10, file = "presence.ts"},["6798"] = {line = 18, file = "presence.ts"},["6805"] = {line = 2, file = "rainbow-delimiters.ts"},["6806"] = {line = 2, file = "rainbow-delimiters.ts"},["6807"] = {line = 4, file = "rainbow-delimiters.ts"},["6808"] = {line = 5, file = "rainbow-delimiters.ts"},["6809"] = {line = 6, file = "rainbow-delimiters.ts"},["6810"] = {line = 7, file = "rainbow-delimiters.ts"},["6811"] = {line = 11, file = "rainbow-delimiters.ts"},["6812"] = {line = 7, file = "rainbow-delimiters.ts"},["6813"] = {line = 4, file = "rainbow-delimiters.ts"},["6814"] = {line = 14, file = "rainbow-delimiters.ts"},["6821"] = {line = 2, file = "rest.ts"},["6822"] = {line = 5, file = "rest.ts"},["6829"] = {line = 3, file = "rustaceanvim.ts"},["6830"] = {line = 4, file = "rustaceanvim.ts"},["6831"] = {line = 3, file = "rustaceanvim.ts"},["6832"] = {line = 20, file = "rustaceanvim.ts"},["6833"] = {line = 21, file = "rustaceanvim.ts"},["6834"] = {line = 22, file = "rustaceanvim.ts"},["6835"] = {line = 23, file = "rustaceanvim.ts"},["6836"] = {line = 24, file = "rustaceanvim.ts"},["6837"] = {line = 28, file = "rustaceanvim.ts"},["6838"] = {line = 29, file = "rustaceanvim.ts"},["6839"] = {line = 30, file = "rustaceanvim.ts"},["6840"] = {line = 28, file = "rustaceanvim.ts"},["6841"] = {line = 20, file = "rustaceanvim.ts"},["6842"] = {line = 40, file = "rustaceanvim.ts"},["6849"] = {line = 4, file = "screenkey.ts"},["6850"] = {line = 9, file = "screenkey.ts"},["6857"] = {line = 2, file = "surround.ts"},["6858"] = {line = 2, file = "surround.ts"},["6859"] = {line = 4, file = "surround.ts"},["6860"] = {line = 5, file = "surround.ts"},["6861"] = {line = 6, file = "surround.ts"},["6862"] = {line = 7, file = "surround.ts"},["6863"] = {line = 8, file = "surround.ts"},["6864"] = {line = 9, file = "surround.ts"},["6865"] = {line = 8, file = "surround.ts"},["6866"] = {line = 4, file = "surround.ts"},["6867"] = {line = 12, file = "surround.ts"},["6874"] = {line = 2, file = "symbol-usage.ts"},["6875"] = {line = 2, file = "symbol-usage.ts"},["6876"] = {line = 11, file = "symbol-usage.ts"},["6877"] = {line = 12, file = "symbol-usage.ts"},["6878"] = {line = 13, file = "symbol-usage.ts"},["6879"] = {line = 14, file = "symbol-usage.ts"},["6880"] = {line = 15, file = "symbol-usage.ts"},["6881"] = {line = 16, file = "symbol-usage.ts"},["6882"] = {line = 17, file = "symbol-usage.ts"},["6883"] = {line = 18, file = "symbol-usage.ts"},["6884"] = {line = 19, file = "symbol-usage.ts"},["6885"] = {line = 20, file = "symbol-usage.ts"},["6886"] = {line = 21, file = "symbol-usage.ts"},["6887"] = {line = 21, file = "symbol-usage.ts"},["6888"] = {line = 21, file = "symbol-usage.ts"},["6889"] = {line = 21, file = "symbol-usage.ts"},["6890"] = {line = 22, file = "symbol-usage.ts"},["6892"] = {line = 24, file = "symbol-usage.ts"},["6893"] = {line = 25, file = "symbol-usage.ts"},["6894"] = {line = 26, file = "symbol-usage.ts"},["6896"] = {line = 28, file = "symbol-usage.ts"},["6897"] = {line = 29, file = "symbol-usage.ts"},["6898"] = {line = 30, file = "symbol-usage.ts"},["6899"] = {line = 30, file = "symbol-usage.ts"},["6900"] = {line = 30, file = "symbol-usage.ts"},["6901"] = {line = 30, file = "symbol-usage.ts"},["6902"] = {line = 31, file = "symbol-usage.ts"},["6904"] = {line = 33, file = "symbol-usage.ts"},["6905"] = {line = 34, file = "symbol-usage.ts"},["6906"] = {line = 35, file = "symbol-usage.ts"},["6908"] = {line = 37, file = "symbol-usage.ts"},["6909"] = {line = 38, file = "symbol-usage.ts"},["6910"] = {line = 39, file = "symbol-usage.ts"},["6911"] = {line = 39, file = "symbol-usage.ts"},["6912"] = {line = 39, file = "symbol-usage.ts"},["6913"] = {line = 39, file = "symbol-usage.ts"},["6914"] = {line = 40, file = "symbol-usage.ts"},["6916"] = {line = 42, file = "symbol-usage.ts"},["6917"] = {line = 43, file = "symbol-usage.ts"},["6918"] = {line = 44, file = "symbol-usage.ts"},["6920"] = {line = 46, file = "symbol-usage.ts"},["6921"] = {line = 47, file = "symbol-usage.ts"},["6922"] = {line = 48, file = "symbol-usage.ts"},["6923"] = {line = 49, file = "symbol-usage.ts"},["6925"] = {line = 52, file = "symbol-usage.ts"},["6926"] = {line = 11, file = "symbol-usage.ts"},["6927"] = {line = 55, file = "symbol-usage.ts"},["6928"] = {line = 56, file = "symbol-usage.ts"},["6929"] = {line = 57, file = "symbol-usage.ts"},["6930"] = {line = 58, file = "symbol-usage.ts"},["6931"] = {line = 59, file = "symbol-usage.ts"},["6932"] = {line = 58, file = "symbol-usage.ts"},["6933"] = {line = 55, file = "symbol-usage.ts"},["6934"] = {line = 64, file = "symbol-usage.ts"},["6941"] = {line = 3, file = "telescope-import.ts"},["6942"] = {line = 7, file = "telescope-import.ts"},["6949"] = {line = 2, file = "telescope.ts"},["6950"] = {line = 2, file = "telescope.ts"},["6951"] = {line = 10, file = "telescope.ts"},["6952"] = {line = 15, file = "telescope.ts"},["6953"] = {line = 10, file = "telescope.ts"},["6954"] = {line = 18, file = "telescope.ts"},["6955"] = {line = 19, file = "telescope.ts"},["6956"] = {line = 20, file = "telescope.ts"},["6957"] = {line = 21, file = "telescope.ts"},["6958"] = {line = 22, file = "telescope.ts"},["6959"] = {line = 21, file = "telescope.ts"},["6960"] = {line = 18, file = "telescope.ts"},["6961"] = {line = 31, file = "telescope.ts"},["6968"] = {line = 2, file = "telescope-ui-select.ts"},["6969"] = {line = 2, file = "telescope-ui-select.ts"},["6970"] = {line = 4, file = "telescope-ui-select.ts"},["6971"] = {line = 5, file = "telescope-ui-select.ts"},["6972"] = {line = 6, file = "telescope-ui-select.ts"},["6973"] = {line = 7, file = "telescope-ui-select.ts"},["6974"] = {line = 8, file = "telescope-ui-select.ts"},["6975"] = {line = 7, file = "telescope-ui-select.ts"},["6976"] = {line = 4, file = "telescope-ui-select.ts"},["6977"] = {line = 11, file = "telescope-ui-select.ts"},["6984"] = {line = 2, file = "theme-flow.ts"},["6985"] = {line = 2, file = "theme-flow.ts"},["6986"] = {line = 4, file = "theme-flow.ts"},["6987"] = {line = 5, file = "theme-flow.ts"},["6988"] = {line = 6, file = "theme-flow.ts"},["6989"] = {line = 7, file = "theme-flow.ts"},["6990"] = {line = 8, file = "theme-flow.ts"},["6991"] = {line = 9, file = "theme-flow.ts"},["6992"] = {line = 13, file = "theme-flow.ts"},["6993"] = {line = 14, file = "theme-flow.ts"},["6994"] = {line = 15, file = "theme-flow.ts"},["6995"] = {line = 16, file = "theme-flow.ts"},["6996"] = {line = 17, file = "theme-flow.ts"},["6997"] = {line = 18, file = "theme-flow.ts"},["6998"] = {line = 19, file = "theme-flow.ts"},["6999"] = {line = 13, file = "theme-flow.ts"},["7000"] = {line = 9, file = "theme-flow.ts"},["7001"] = {line = 4, file = "theme-flow.ts"},["7002"] = {line = 23, file = "theme-flow.ts"},["7009"] = {line = 2, file = "time-tracker.ts"},["7010"] = {line = 2, file = "time-tracker.ts"},["7011"] = {line = 4, file = "time-tracker.ts"},["7012"] = {line = 5, file = "time-tracker.ts"},["7013"] = {line = 6, file = "time-tracker.ts"},["7014"] = {line = 7, file = "time-tracker.ts"},["7015"] = {line = 8, file = "time-tracker.ts"},["7016"] = {line = 9, file = "time-tracker.ts"},["7017"] = {line = 10, file = "time-tracker.ts"},["7018"] = {line = 11, file = "time-tracker.ts"},["7019"] = {line = 12, file = "time-tracker.ts"},["7020"] = {line = 12, file = "time-tracker.ts"},["7021"] = {line = 12, file = "time-tracker.ts"},["7022"] = {line = 12, file = "time-tracker.ts"},["7023"] = {line = 12, file = "time-tracker.ts"},["7024"] = {line = 12, file = "time-tracker.ts"},["7025"] = {line = 12, file = "time-tracker.ts"},["7026"] = {line = 13, file = "time-tracker.ts"},["7027"] = {line = 10, file = "time-tracker.ts"},["7028"] = {line = 9, file = "time-tracker.ts"},["7029"] = {line = 4, file = "time-tracker.ts"},["7030"] = {line = 17, file = "time-tracker.ts"},["7037"] = {line = 3, file = "timerly.ts"},["7038"] = {line = 7, file = "timerly.ts"},["7045"] = {line = 2, file = "tiny-inline-diagnostic.ts"},["7046"] = {line = 2, file = "tiny-inline-diagnostic.ts"},["7047"] = {line = 4, file = "tiny-inline-diagnostic.ts"},["7048"] = {line = 20, file = "tiny-inline-diagnostic.ts"},["7049"] = {line = 4, file = "tiny-inline-diagnostic.ts"},["7050"] = {line = 23, file = "tiny-inline-diagnostic.ts"},["7051"] = {line = 24, file = "tiny-inline-diagnostic.ts"},["7052"] = {line = 25, file = "tiny-inline-diagnostic.ts"},["7053"] = {line = 26, file = "tiny-inline-diagnostic.ts"},["7054"] = {line = 27, file = "tiny-inline-diagnostic.ts"},["7055"] = {line = 26, file = "tiny-inline-diagnostic.ts"},["7056"] = {line = 23, file = "tiny-inline-diagnostic.ts"},["7057"] = {line = 34, file = "tiny-inline-diagnostic.ts"},["7064"] = {line = 3, file = "todo-comments.ts"},["7065"] = {line = 8, file = "todo-comments.ts"},["7072"] = {line = 3, file = "tokyonight.ts"},["7073"] = {line = 9, file = "tokyonight.ts"},["7080"] = {line = 2, file = "treesitter-context.ts"},["7081"] = {line = 2, file = "treesitter-context.ts"},["7082"] = {line = 4, file = "treesitter-context.ts"},["7083"] = {line = 9, file = "treesitter-context.ts"},["7084"] = {line = 4, file = "treesitter-context.ts"},["7085"] = {line = 12, file = "treesitter-context.ts"},["7086"] = {line = 13, file = "treesitter-context.ts"},["7087"] = {line = 14, file = "treesitter-context.ts"},["7088"] = {line = 15, file = "treesitter-context.ts"},["7089"] = {line = 16, file = "treesitter-context.ts"},["7090"] = {line = 15, file = "treesitter-context.ts"},["7091"] = {line = 12, file = "treesitter-context.ts"},["7092"] = {line = 23, file = "treesitter-context.ts"},["7099"] = {line = 2, file = "treesitter.ts"},["7100"] = {line = 2, file = "treesitter.ts"},["7101"] = {line = 8, file = "treesitter.ts"},["7102"] = {line = 8, file = "treesitter.ts"},["7103"] = {line = 8, file = "treesitter.ts"},["7104"] = {line = 8, file = "treesitter.ts"},["7106"] = {line = 8, file = "treesitter.ts"},["7108"] = {line = 4, file = "treesitter.ts"},["7109"] = {line = 12, file = "treesitter.ts"},["7116"] = {line = 2, file = "treesj.ts"},["7117"] = {line = 2, file = "treesj.ts"},["7118"] = {line = 3, file = "treesj.ts"},["7119"] = {line = 3, file = "treesj.ts"},["7120"] = {line = 5, file = "treesj.ts"},["7121"] = {line = 10, file = "treesj.ts"},["7122"] = {line = 5, file = "treesj.ts"},["7123"] = {line = 13, file = "treesj.ts"},["7124"] = {line = 14, file = "treesj.ts"},["7125"] = {line = 15, file = "treesj.ts"},["7126"] = {line = 16, file = "treesj.ts"},["7127"] = {line = 17, file = "treesj.ts"},["7128"] = {line = 18, file = "treesj.ts"},["7129"] = {line = 19, file = "treesj.ts"},["7130"] = {line = 20, file = "treesj.ts"},["7131"] = {line = 21, file = "treesj.ts"},["7132"] = {line = 22, file = "treesj.ts"},["7133"] = {line = 21, file = "treesj.ts"},["7134"] = {line = 24, file = "treesj.ts"},["7135"] = {line = 18, file = "treesj.ts"},["7136"] = {line = 28, file = "treesj.ts"},["7137"] = {line = 17, file = "treesj.ts"},["7138"] = {line = 13, file = "treesj.ts"},["7139"] = {line = 34, file = "treesj.ts"},["7146"] = {line = 3, file = "trouble.ts"},["7147"] = {line = 8, file = "trouble.ts"},["7154"] = {line = 2, file = "ts-autotag.ts"},["7155"] = {line = 2, file = "ts-autotag.ts"},["7156"] = {line = 4, file = "ts-autotag.ts"},["7157"] = {line = 5, file = "ts-autotag.ts"},["7158"] = {line = 6, file = "ts-autotag.ts"},["7159"] = {line = 7, file = "ts-autotag.ts"},["7160"] = {line = 11, file = "ts-autotag.ts"},["7161"] = {line = 7, file = "ts-autotag.ts"},["7162"] = {line = 4, file = "ts-autotag.ts"},["7163"] = {line = 17, file = "ts-autotag.ts"},["7170"] = {line = 2, file = "ufo.ts"},["7171"] = {line = 2, file = "ufo.ts"},["7172"] = {line = 3, file = "ufo.ts"},["7173"] = {line = 3, file = "ufo.ts"},["7174"] = {line = 5, file = "ufo.ts"},["7175"] = {line = 6, file = "ufo.ts"},["7176"] = {line = 7, file = "ufo.ts"},["7177"] = {line = 8, file = "ufo.ts"},["7178"] = {line = 9, file = "ufo.ts"},["7179"] = {line = 10, file = "ufo.ts"},["7180"] = {line = 11, file = "ufo.ts"},["7181"] = {line = 12, file = "ufo.ts"},["7182"] = {line = 13, file = "ufo.ts"},["7183"] = {line = 15, file = "ufo.ts"},["7184"] = {line = 16, file = "ufo.ts"},["7185"] = {line = 20, file = "ufo.ts"},["7186"] = {line = 21, file = "ufo.ts"},["7187"] = {line = 20, file = "ufo.ts"},["7188"] = {line = 26, file = "ufo.ts"},["7189"] = {line = 9, file = "ufo.ts"},["7190"] = {line = 5, file = "ufo.ts"},["7191"] = {line = 31, file = "ufo.ts"},["7198"] = {line = 3, file = "ultimate-autopair.ts"},["7199"] = {line = 15, file = "ultimate-autopair.ts"},["7206"] = {line = 2, file = "undotree.ts"},["7207"] = {line = 2, file = "undotree.ts"},["7208"] = {line = 11, file = "undotree.ts"},["7209"] = {line = 12, file = "undotree.ts"},["7210"] = {line = 11, file = "undotree.ts"},["7211"] = {line = 15, file = "undotree.ts"},["7212"] = {line = 16, file = "undotree.ts"},["7213"] = {line = 17, file = "undotree.ts"},["7214"] = {line = 18, file = "undotree.ts"},["7215"] = {line = 21, file = "undotree.ts"},["7216"] = {line = 21, file = "undotree.ts"},["7217"] = {line = 21, file = "undotree.ts"},["7218"] = {line = 22, file = "undotree.ts"},["7219"] = {line = 21, file = "undotree.ts"},["7220"] = {line = 23, file = "undotree.ts"},["7221"] = {line = 21, file = "undotree.ts"},["7222"] = {line = 24, file = "undotree.ts"},["7223"] = {line = 24, file = "undotree.ts"},["7224"] = {line = 24, file = "undotree.ts"},["7225"] = {line = 25, file = "undotree.ts"},["7226"] = {line = 24, file = "undotree.ts"},["7227"] = {line = 26, file = "undotree.ts"},["7228"] = {line = 24, file = "undotree.ts"},["7229"] = {line = 27, file = "undotree.ts"},["7230"] = {line = 27, file = "undotree.ts"},["7231"] = {line = 27, file = "undotree.ts"},["7232"] = {line = 28, file = "undotree.ts"},["7233"] = {line = 27, file = "undotree.ts"},["7234"] = {line = 29, file = "undotree.ts"},["7235"] = {line = 27, file = "undotree.ts"},["7236"] = {line = 17, file = "undotree.ts"},["7237"] = {line = 31, file = "undotree.ts"},["7238"] = {line = 15, file = "undotree.ts"},["7239"] = {line = 35, file = "undotree.ts"},["7246"] = {line = 3, file = "wakatime.ts"},["7247"] = {line = 7, file = "wakatime.ts"}});
return require("main", ...)
